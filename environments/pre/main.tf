module "app_service_pre" {
  source = "../../modules/app_service"

  app_name       = "ecoanalyzer-pre"
  location       = var.location
  resource_group = var.resource_group_name
  app_env        = "PRE"
  sku_name       = "B1"
}
