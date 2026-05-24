variable "project" {
  type        = string
  description = "Project name for naming the Key Vault."
}

variable "environment" {
  type        = string
  description = "Environment (pre/pro)."
}

variable "location" {
  type        = string
  description = "Azure region."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group where the Key Vault will be created."
}

variable "tenant_id" {
  type        = string
  description = "Tenant ID for the Key Vault."
}

variable "ghcr_token" {
  type        = string
  sensitive   = true
  description = "GHCR token to store as a secret."
}

variable "api_key" {
  type        = string
  sensitive   = true
  description = "API key to store as a secret."
}

variable "jwt_secret" {
  type        = string
  sensitive   = true
  description = "JWT secret to store as a secret."
}

variable "allowed_ip_ranges" {
  type        = list(string)
  default     = []
  description = "Optional list of IP ranges allowed to access the Key Vault."
}

variable "secrets_expiration_date" {
  type        = string
  description = "Expiration date for secrets in RFC3339 format (e.g. 2026-12-31T00:00:00Z)."
}
