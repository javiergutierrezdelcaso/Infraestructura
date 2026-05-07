############################################
# RESOURCE GROUP
############################################

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

############################################
# ENTORNO PRE
############################################

module "app_service_pre" {
  source = "./modules/app_service"

  app_name        = "${var.project_name}-pre"
  location        = var.location
  resource_group  = azurerm_resource_group.rg.name
  app_env         = "PRE"
  sku_name        = var.sku_name
}

############################################
# ENTORNO PRO
############################################

module "app_service_pro" {
  source = "./modules/app_service"

  app_name        = "${var.project_name}-pro"
  location        = var.location
  resource_group  = azurerm_resource_group.rg.name
  app_env         = "PRO"
  sku_name        = var.sku_name
}

############################################
# OUTPUTS
############################################

output "pre_app_url" {
  description = "URL del App Service PRE"
  value       = module.app_service_pre.app_url
}

output "pro_app_url" {
  description = "URL del App Service PRO"
  value       = module.app_service_pro.app_url
}
