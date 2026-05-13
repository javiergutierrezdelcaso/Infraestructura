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
