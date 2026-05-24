variable "project" {
  type    = string
  default = "ecoanalyzer"
}

variable "location" {
  type    = string
  default = "spaincentral"
}

variable "environment" {
  type = string
}

variable "arm_client_id" {
  type = string
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

variable "ghcr_token" {
  type      = string
  sensitive = true
  default   = ""
}

variable "api_key" {
  type      = string
  sensitive = true
  default   = ""
}

variable "jwt_secret" {
  type      = string
  sensitive = true
  default   = ""
}