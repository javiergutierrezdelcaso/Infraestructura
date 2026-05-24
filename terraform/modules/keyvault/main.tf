resource "azurerm_key_vault" "this" {
  name                = "kv-${var.project}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id
  sku_name            = "standard"

  purge_protection_enabled   = true
  soft_delete_retention_days = 7

  # Cumple tfsec: azure-keyvault-specify-network-acl
  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"

    dynamic "ip_rules" {
      for_each = var.allowed_ip_ranges
      content {
        value = ip_rules.value
      }
    }
  }
}

resource "azurerm_key_vault_secret" "ghcr_token" {
  name         = "GHCR-TOKEN"
  value        = var.ghcr_token
  key_vault_id = azurerm_key_vault.this.id

  # Cumple tfsec: azure-keyvault-content-type-for-secret
  content_type = "text/plain"

  # Cumple tfsec: azure-keyvault-ensure-secret-expiry
  expiration_date = var.secrets_expiration_date
}

resource "azurerm_key_vault_secret" "api_key" {
  name         = "API-KEY"
  value        = var.api_key
  key_vault_id = azurerm_key_vault.this.id

  content_type   = "text/plain"
  expiration_date = var.secrets_expiration_date
}

resource "azurerm_key_vault_secret" "jwt_secret" {
  name         = "JWT-SECRET"
  value        = var.jwt_secret
  key_vault_id = azurerm_key_vault.this.id

  content_type   = "text/plain"
  expiration_date = var.secrets_expiration_date
}
