output "app_id" {
  value = azurerm_linux_web_app.app.id
}

output "identity_principal_id" {
  value = azurerm_user_assigned_identity.identity.principal_id
}


output "identity_id" {
  value = azurerm_user_assigned_identity.identity.id
}
