resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

module "app_service_pre" {
  source = "./modules/app_service"

  app_name        = "${var.project_name}-pre"
  location        = var.location
  resource_group  = azurerm_resource_group.rg.name
  app_env         = "PRE"
  sku_name        = "B1"
}

module "app_service_pro" {
  source = "./modules/app_service"

  app_name        = "${var.project_name}-pro"
  location        = var.location
  resource_group  = azurerm_resource_group.rg.name
  app_env         = "PRO"
  sku_name        = "B1"
}
