variable "app_name" {
  type        = string
  description = "Nombre del App Service"
}

variable "location" {
  type        = string
  description = "Región de Azure"
}

variable "resource_group" {
  type        = string
  description = "Nombre del Resource Group"
}

variable "app_env" {
  type        = string
  description = "Entorno de la aplicación (PRE, PRO, DEV)"
}

variable "sku_name" {
  type        = string
  description = "SKU del App Service Plan"
  default     = "B1"
}
