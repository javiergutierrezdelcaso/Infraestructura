variable "project" {
  type    = string
  default = "ecoanalyzer"
}

variable "location" {
  type    = string
  default = "spaincentral"
}

variable "resource_group_name" {
  type    = string
  default = "rg-ecoanalyzer"
}

variable "tenant_id" {
  type    = string
  default = ""
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

variable "subnet_id" {
  type    = string
  default = ""
}

variable "log_analytics_workspace_id" {
  type    = string
  default = ""
}
