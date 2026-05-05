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
