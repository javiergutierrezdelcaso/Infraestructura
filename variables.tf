variable "project_name" {
  type        = string
  description = "Nombre del proyecto"
  default     = "ecoanalyzer"
}

variable "location" {
  type        = string
  description = "Región de Azure"
  default     = "westeurope"
}

variable "resource_group_name" {
  type        = string
  description = "Nombre del Resource Group"
  default     = "rg-ecoanalyzer"
}
