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
  default = "rg-ecoanalyzer-pre"
}

variable "tenant_id" {
  type    = string
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

variable "secrets_expiration_date" {
  type    = string
  default = "2026-12-31T00:00:00Z"
}

variable "sku_name" {
  type    = string
  default = "B1"
}
