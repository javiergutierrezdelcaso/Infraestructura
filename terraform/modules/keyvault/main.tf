###############################################
# KEY VAULT
###############################################

resource "azurerm_key_vault" "this" {
  name                = "kv-${var.project}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id
  sku_name            = "standard"

  purge_protection_enabled   = true
  soft_delete_retention_days = 7

  public_network_access_enabled = false

  network_acls {
    default_action = "Deny"
    bypass         = "None"
  }
}

###############################################
# SECRETS
###############################################

resource "azurerm_key_vault_secret" "ghcr_token" {
  name         = "ghcr-token"
  value        = var.ghcr_token
  key_vault_id = azurerm_key_vault.this.id

  content_type    = "token"
  expiration_date = var.secrets_expiration_date
}

resource "azurerm_key_vault_secret" "api_key" {
  name         = "api-key"
  value        = var.api_key
  key_vault_id = azurerm_key_vault.this.id

  content_type    = "api-key"
  expiration_date = var.secrets_expiration_date
}

resource "azurerm_key_vault_secret" "jwt_secret" {
  name         = "jwt-secret"
  value        = var.jwt_secret
  key_vault_id = azurerm_key_vault.this.id

  content_type    = "jwt-secret"
  expiration_date = var.secrets_expiration_date
}

###############################################
# PRIVATE ENDPOINT
###############################################

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

###############################################
# DIAGNOSTIC SETTINGS (LOGGING)
###############################################

resource "azurerm_monitor_diagnostic_setting" "kv_logs" {
  name                       = "kv-logs-${var.environment}"
  target_resource_id         = azurerm_key_vault.this.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  log {
    category = "AuditEvent"
    enabled  = true
  }

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}

###############################################
# OUTPUTS
###############################################

output "key_vault_id" {
  value = azurerm_key_vault.this.id
}

output "ghcr_token_secret_uri" {
  value = azurerm_key_vault_secret.ghcr_token.id
}

output "api_key_secret_uri" {
  value = azurerm_key_vault_secret.api_key.id
}

output "jwt_secret_secret_uri" {
  value = azurerm_key_vault_secret.jwt_secret.id
}

