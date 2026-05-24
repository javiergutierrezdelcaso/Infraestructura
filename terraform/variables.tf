###############################################
# VARIABLES GENERALES
###############################################

variable "project" {
  type        = string
  description = "Nombre del proyecto."
}

variable "location" {
  type        = string
  description = "Región de Azure."
}

variable "arm_client_id" {
  type        = string
}

variable "arm_client_secret" {
  type      = string
  sensitive = true
}

variable "arm_tenant_id" {
  type = string
}

variable "arm_subscription_id" {
  type = string
}

###############################################
# SECRETS PARA KEY VAULT
###############################################

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
