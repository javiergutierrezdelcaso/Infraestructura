############################################
# RESOURCE GROUP
############################################

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

############################################
# APP SERVICE PRE
############################################

module "app_service_pre" {
  source = "./modules/app_service"
  count  = var.environment == "pre" ? 1 : 0

  app_name       = "ecoanalyzer-pre"
  app_env        = "PRE"
  location       = var.location
  resource_group = var.resource_group_name
  sku_name       = var.sku_name
}

############################################
# APP SERVICE PRO
############################################

module "app_service_pro" {
  source = "./modules/app_service"
  count  = var.environment == "pro" ? 1 : 0

  app_name       = "ecoanalyzer-pro"
  app_env        = "PRO"
  location       = var.location
  resource_group = var.resource_group_name
  sku_name       = var.sku_name
}
