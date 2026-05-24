output "pre_app_url" {
  description = "URL de la aplicación PRE."
  value       = module.app_service_pre.app_url
}

output "pro_app_url" {
  description = "URL de la aplicación PRO."
  value       = module.app_service_pro.app_url
}
