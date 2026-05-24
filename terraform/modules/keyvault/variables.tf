variable "project" { type = string }
variable "environment" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "tenant_id" { type = string }

variable "ghcr_token" { type = string }
variable "api_key" { type = string }
variable "jwt_secret" { type = string }

variable "subnet_id" { type = string }
variable "log_analytics_workspace_id" { type = string }

variable "secrets_expiration_date" { type = string }
