############################################
# ENTORNO PRO
############################################

module "app_service_pro" {
  source = "../../app_service"

  app_name        = "${var.project_name}-pro"
  location        = var.location
  resource_group  = var.resource_group_name
  app_env         = "PRO"
  sku_name        = var.sku_name
}
