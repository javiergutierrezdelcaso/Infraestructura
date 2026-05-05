output "pre_app_url" {
  value       = module.app_service_pre.default_hostname
  description = "URL del App Service PRE"
}

output "pro_app_url" {
  value       = module.app_service_pro.default_hostname
  description = "URL del App Service PRO"
}
