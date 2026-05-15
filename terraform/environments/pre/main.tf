provider "azurerm" {
  features {}
}

module "app_service" {
  source = "../../modules/app_service"

  app_name       = "ecoanalyzer-pre"
  location       = var.location
  resource_group = "rg-ecoanalyzer-pre"
  app_env        = "pre"
  sku_name       = "F1"
}
