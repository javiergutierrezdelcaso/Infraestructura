############################################
# RESOURCE GROUP PRO
############################################

resource "azurerm_resource_group" "pro" {
  name     = var.resource_group_name
  location = var.location
}

############################################
# NETWORK PRO
############################################

module "network_pro" {
  source              = "../modules/network"
  project             = var.project
  environment         = "pro"
  location            = var.location
  resource_group_name = azurerm_resource_group.pro.name
}

############################################
# LOG ANALYTICS PRO
############################################

module "log_analytics_pro" {
  source              = "../modules/log_analytics"
  project             = var.project
  environment         = "pro"
  location            = var.location
  resource_group_name = azurerm_resource_group.pro.name
}

############################################
# KEY VAULT PRO
############################################

module "keyvault_pro" {
  source              = "../modules/keyvault"
  project             = var.project
  environment         = "pro"
  location            = var.location
  resource_group_name = azurerm_resource_group.pro.name
  tenant_id           = var.tenant_id

  ghcr_token = var.ghcr_token
  api_key    = var.api_key
  jwt_secret = var.jwt_secret

  subnet_id                  = module.network_pro.subnet_id
  log_analytics_workspace_id = module.log_analytics_pro.workspace_id

  secrets_expiration_date = var.secrets_expiration_date
  allowed_ip_ranges       = []
}

############################################
# APP SERVICE PRO
############################################

module "app_service_pro" {
  source              = "../modules/app_service"
  project             = var.project
  environment         = "pro"
  location            = var.location
  resource_group_name = azurerm_resource_group.pro.name
  sku_name            = var.sku_name
}
