############################################
# ENTORNO (PRE / PRO)
############################################

variable "environment" {
  type        = string
  description = "Entorno de despliegue: pre o pro"
}

############################################
# UBICACIÓN
############################################

variable "location" {
  type    = string
  default = "spaincentral"
}

############################################
# RESOURCE GROUP
############################################

variable "resource_group_name" {
  type    = string
  default = "rg-ecoanalyzer"
}

############################################
# SKU DEL APP SERVICE PLAN
############################################

variable "sku_name" {
  type    = string
  default = "F1"
}

############################################
# SECRETS (Key Vault)
############################################

variable "ghcr_token" {
  type        = string
  sensitive   = true
  description = "Token de GHCR para pull de contenedores"
}

variable "api_key" {
  type        = string
  sensitive   = true
  description = "API Key del microservicio"
}

variable "jwt_secret" {
  type        = string
  sensitive   = true
  description = "JWT secret del microservicio"
}

############################################
# AUTENTICACIÓN ARM (NO OIDC)
############################################

variable "arm_client_id" {
  type        = string
  description = "Client ID de la aplicación registrada en Azure"
}

variable "arm_client_secret" {
  type        = string
  sensitive   = true
  description = "Client Secret de la aplicación registrada en Azure"
}

variable "arm_tenant_id" {
  type        = string
  description = "Tenant ID de Azure"
}

variable "arm_subscription_id" {
  type        = string
  description = "Subscription ID de Azure"
}
