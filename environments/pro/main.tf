module "app_service_pro" {
  source = "../../modules/app_service"

  app_name       = "ecoanalyzer-pro"
  location       = var.location
  resource_group = var.resource_group_name
  app_env        = "PRO"
  sku_name       = "B1"
}
