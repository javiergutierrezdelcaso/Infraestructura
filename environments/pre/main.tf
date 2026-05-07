############################################
# ENTORNO PRE
############################################

module "app_service_pre" {
  source = "../../app_service"

  app_name        = "${var.project_name}-pre"
  location        = var.location
  resource_group  = var.resource_group_name
  app_env         = "PRE"
  sku_name        = var.sku_name
}
