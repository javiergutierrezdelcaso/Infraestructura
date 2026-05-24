###############################################
# OUTPUTS DE APP SERVICE
###############################################

output "pre_app_url" {
  description = "URL de la aplicación desplegada en PRE."
  value       = module.app_service_pre.app_url
}

output "pro_app_url" {
  description = "URL de la aplicación desplegada en PRO."
  value       = module.app_service_pro.app_url
}
