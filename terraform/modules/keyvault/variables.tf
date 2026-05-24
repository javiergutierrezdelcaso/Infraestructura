variable "project" {
  type        = string
  description = "Nombre del proyecto (ecoanalyzer)"
}

variable "environment" {
  type        = string
  description = "Entorno (pre|pro)"
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "app_identity_principal_id" {
  type        = string
  description = "Principal ID de la identidad administrada del App Service"
}

variable "ghcr_token" {
  type      = string
  sensitive = true
}

variable "api_key" {
  type      = string
  sensitive = true
}

variable "jwt_secret" {
  type      = string
  sensitive = true
}
