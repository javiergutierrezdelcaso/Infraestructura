resource "azurerm_resource_group" "pre" {
  name     = "rg-${var.project}-pre"
  location = var.location
}

module "network_pre" {
  source              = "../../modules/network"
  project             = var.project
  environment         = "pre"
  location            = var.location
  resource_group_name = azurerm_resource_group.pre.name
}

module "log_pre" {
  source              = "../../modules/log_analytics"
  project             = var.project
  environment         = "pre"
  location            = var.location
  resource_group_name = azurerm_resource_group.pre.name
}

module "keyvault_pre" {
  source                        = "../../modules/keyvault"
  project                       = var.project
  environment                   = "pre"
  location                      = var.location
  resource_group_name           = azurerm_resource_group.pre.name
  tenant_id                     = var.tenant_id
  ghcr_token                    = var.ghcr_token
  api_key                       = var.api_key
  jwt_secret                    = var.jwt_secret
  subnet_id                     = module.network_pre.subnet_id
  log_analytics_workspace_id    = module.log_pre.workspace_id
  secrets_expiration_date       = var.secrets_expiration_date
}

module "app_service_pre" {
  source              = "../../modules/app_service"
  project             = var.project
  environment         = "pre"
  location            = var.location
  resource_group_name = azurerm_resource_group.pre.name
  sku_name            = var.sku_name
}
