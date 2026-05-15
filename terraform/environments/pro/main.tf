provider "azurerm" {
  features {}
}

module "app_service" {
  source = "../../modules/app_service"

  app_name       = "ecoanalyzer-pro"
  location       = var.location
  resource_group = "rg-ecoanalyzer-pro"
  app_env        = "pro"
  sku_name       = "F1"
}
