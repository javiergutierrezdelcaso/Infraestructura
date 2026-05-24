variable "project" {
  type = string
}

variable "environment" {
  type = string
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

variable "allowed_ip_ranges" {
  type    = list(string)
  default = []
}

variable "secrets_expiration_date" {
  type = string
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
  type = string
}
