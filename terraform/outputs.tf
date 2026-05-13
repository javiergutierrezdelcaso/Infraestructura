output "pre_app_url" {
  value = var.environment == "pre" ? module.app_service_pre[0].app_url : null
}

output "pro_app_url" {
  value = var.environment == "pro" ? module.app_service_pro[0].app_url : null
}
