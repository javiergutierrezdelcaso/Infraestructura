############################################
# OUTPUTS DEL MÓDULO APP SERVICE
############################################

output "app_url" {
  description = "Hostname público del App Service"
  value       = azurerm_linux_web_app.app.default_hostname
}

output "app_id" {
  description = "ID del App Service"
  value       = azurerm_linux_web_app.app.id
}

output "plan_id" {
  description = "ID del App Service Plan"
  value       = azurerm_service_plan.plan.id
}
