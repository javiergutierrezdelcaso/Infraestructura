############################################
# VARIABLES DEL PROYECTO
############################################

variable "project_name" {
  type        = string
  description = "Nombre del proyecto"
  default     = "ecoanalyzer"
}

variable "location" {
  type        = string
  description = "Región de Azure donde se desplegarán los recursos"
  default     = "westeurope"
}

variable "resource_group_name" {
  type        = string
  description = "Nombre del Resource Group principal"
  default     = "rg-ecoanalyzer"
}

############################################
# VARIABLES DE AUTENTICACIÓN (TERRAFORM CLOUD)
############################################

variable "client_id" {
  type        = string
  description = "Client ID del Service Principal usado por Terraform Cloud"
}

variable "client_secret" {
  type        = string
  description = "Client Secret del Service Principal"
  sensitive   = true
}

variable "tenant_id" {
  type        = string
  description = "Tenant ID de Azure"
}

variable "subscription_id" {
  type        = string
  description = "Subscription ID de Azure"
}

############################################
# VARIABLES DE LA APLICACIÓN
############################################

variable "app_env" {
  type        = string
  description = "Entorno de despliegue (dev, test, prod)"
  default     = "dev"
}

variable "sku_name" {
  type        = string
  description = "SKU del App Service Plan"
  default     = "B1"
}

variable "app_name" {
  type        = string
  description = "Nombre de la aplicación App Service"
  default     = "ecoanalyzer-app"
}
