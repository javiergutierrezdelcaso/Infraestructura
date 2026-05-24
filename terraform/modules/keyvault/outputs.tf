output "ghcr_token_secret_uri" {
  value = azurerm_key_vault_secret.ghcr_token.id
}

output "api_key_secret_uri" {
  value = azurerm_key_vault_secret.api_key.id
}

output "jwt_secret_secret_uri" {
  value = azurerm_key_vault_secret.jwt_secret.id
}
