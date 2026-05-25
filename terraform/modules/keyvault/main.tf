# checkov:skip=CKV_AZURE_110: purge protection no disponible en Azure for Students
# checkov:skip=CKV_AZURE_42: soft delete habilitado, purge protection no permitida
# checkov:skip=CKV_AZURE_189: PNA no puede deshabilitarse en Azure for Students
# tfsec:ignore:azure-keyvault-no-purge
resource "azurerm_key_vault" "this" {
  name                          = "kv-${var.project}-${var.environment}"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  tenant_id                     = var.tenant_id
  sku_name                      = "standard"
  soft_delete_retention_days    = 7
  purge_protection_enabled      = false
  public_network_access_enabled = true

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
  }

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.client_object_id

    secret_permissions = [
      "Get",
      "Set",
      "List",
      "Delete",
      "Recover",
      "Purge"
    ]
  }
}

# Espera para que Azure propague la access policy (evita 403)
resource "time_sleep" "wait_for_kv_policy" {
  depends_on      = [azurerm_key_vault.this]
  create_duration = "30s"
}

resource "azurerm_private_endpoint" "this" {
  name                = "${var.project}-${var.environment}-kv-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "kv-connection-${var.environment}"
    private_connection_resource_id = azurerm_key_vault.this.id
    subresource_names              = ["vault"]
    is_manual_connection           = false
  }
}

# ---------- DIAGNOSTIC SETTING IDEMPOTENTE (NO USA azurerm_monitor_diagnostic_setting) ----------

resource "null_resource" "kv_logs" {
  depends_on = [azurerm_key_vault.this]

  provisioner "local-exec" {
    command     = <<EOT
set -e

if az monitor diagnostic-settings show \
  --name "kv-logs-${var.environment}" \
  --resource "${azurerm_key_vault.this.id}" >/dev/null 2>&1; then
  echo "Diagnostic setting kv-logs-${var.environment} ya existe, no se crea."
else
  echo "Diagnostic setting kv-logs-${var.environment} no existe, se crea..."
  az monitor diagnostic-settings create \
    --name "kv-logs-${var.environment}" \
    --resource "${azurerm_key_vault.this.id}" \
    --workspace "${var.log_analytics_workspace_id}" \
    --logs '[{"category":"AuditEvent","enabled":true}]' \
    --metrics '[{"category":"AllMetrics","enabled":true}]'
fi
EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

# ---------- SECRETS (CON ESPERA PARA EVITAR 403) ----------

resource "azurerm_key_vault_secret" "ghcr_token" {
  name            = "ghcr-token"
  value           = var.ghcr_token
  key_vault_id    = azurerm_key_vault.this.id
  content_type    = "token"
  expiration_date = var.secrets_expiration_date

  depends_on = [
    time_sleep.wait_for_kv_policy
  ]
}

resource "azurerm_key_vault_secret" "api_key" {
  name            = "api-key"
  value           = var.api_key
  key_vault_id    = azurerm_key_vault.this.id
  content_type    = "api-key"
  expiration_date = var.secrets_expiration_date

  depends_on = [
    time_sleep.wait_for_kv_policy
  ]
}

resource "azurerm_key_vault_secret" "jwt_secret" {
  name            = "jwt-secret"
  value           = var.jwt_secret
  key_vault_id    = azurerm_key_vault.this.id
  content_type    = "jwt-secret"
  expiration_date = var.secrets_expiration_date

  depends_on = [
    time_sleep.wait_for_kv_policy
  ]
}
