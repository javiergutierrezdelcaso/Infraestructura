###############################################
# RESOURCE GROUPS
###############################################

resource "azurerm_resource_group" "pre" {
  name     = "${var.project}-pre-rg"
  location = var.location
}

resource "azurerm_resource_group" "pro" {
  name     = "${var.project}-pro-rg"
  location = var.location
}

###############################################
# KEY VAULT PRE
###############################################

module "keyvault_pre" {
  source = "./modules/keyvault"

  project             = var.project
  environment         = "pre"
  location            = var.location
  resource_group_name = azurerm_resource_group.pre.name
  tenant_id           = var.arm_tenant_id

  ghcr_token = var.ghcr_token
  api_key    = var.api_key
  jwt_secret = var.jwt_secret

  allowed_ip_ranges       = []
  secrets_expiration_date = "2026-12-31T00:00:00Z"
}

###############################################
# KEY VAULT PRO
###############################################

module "keyvault_pro" {
  source = "./modules/keyvault"

  project             = var.project
  environment         = "pro"
  location            = var.location
  resource_group_name = azurerm_resource_group.pro.name
  tenant_id           = var.arm_tenant_id

  ghcr_token = var.ghcr_token
  api_key    = var.api_key
  jwt_secret = var.jwt_secret

  allowed_ip_ranges       = []
  secrets_expiration_date = "2026-12-31T00:00:00Z"
}

###############################################
# APP SERVICE PRE
###############################################

module "app_service_pre" {
  source = "./modules/app_service"

  project             = var.project
  environment         = "pre"
  location            = var.location
  resource_group_name = azurerm_resource_group.pre.name
}

###############################################
# APP SERVICE PRO
###############################################

module "app_service_pro" {
  source = "./modules/app_service"

  project             = var.project
  environment         = "pro"
  location            = var.location
  resource_group_name = azurerm_resource_group.pro.name
}
