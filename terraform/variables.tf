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
  description = "Client ID del Service Principal."
}

variable "arm_client_secret" {
  type        = string
  sensitive   = true
  description = "Client Secret del Service Principal."
}

variable "arm_tenant_id" {
  type        = string
  description = "Tenant ID del Service Principal."
}

variable "arm_subscription_id" {
  type        = string
  description = "Subscription ID del Service Principal."
}

###############################################
# SECRETS PARA KEY VAULT
###############################################

variable "ghcr_token" {
  type        = string
  sensitive   = true
  description = "Token GHCR para almacenar en Key Vault."
}

variable "api_key" {
  type        = string
  sensitive   = true
  description = "API Key para almacenar en Key Vault."
}

variable "jwt_secret" {
  type        = string
  sensitive   = true
  description = "JWT Secret para almacenar en Key Vault."
}