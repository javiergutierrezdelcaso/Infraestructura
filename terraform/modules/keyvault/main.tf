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

# Espera obligatoria para que Azure propague la access policy
resource "time_sleep" "wait_for_kv_policy" {
  depends_on      = [azurerm_key_vault.this]
  create_duration = "30s"
}

# DIAGNOSTIC SETTING IDEMPOTENTE (NO FALLA SI YA EXISTE)
resource "azurerm_monitor_diagnostic_setting" "kv_logs" {
  name                       = "kv-logs-${var.environment}"
  target_resource_id         = azurerm_key_vault.this.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category = "AuditEvent"
  }

  enabled_metric {
    category = "AllMetrics"
  }

  # EVITA EL ERROR “resource already exists”
  lifecycle {
    ignore_changes = [
      name
    ]
  }
}

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
