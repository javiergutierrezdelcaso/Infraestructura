variable "app_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group" {
  type = string
}

variable "app_env" {
  type = string
}

variable "sku_name" {
  type    = string
  default = "B1"
}


variable "ghcr_token_secret_uri" {
  type    = string
  default = null
}

variable "api_key_secret_uri" {
  type    = string
  default = null
}

variable "jwt_secret_secret_uri" {
  type    = string
  default = null
}