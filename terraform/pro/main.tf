############################################
# PROVIDER
############################################

provider "azurerm" {
  features {}
}

############################################
# KEY VAULT PRO
############################################

module "keyvault_pro" {
  source = "../modules/keyvault"

  project             = var.project
  environment         = "pro"
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id

  ghcr_token = var.ghcr_token
  api_key    = var.api_key
  jwt_secret = var.jwt_secret

  allowed_ip_ranges       = []
  secrets_expiration_date = "2026-12-31T00:00:00Z"

  subnet_id                  = var.subnet_id
  log_analytics_workspace_id = var.log_analytics_workspace_id
}

############################################
# APP SERVICE PRO
############################################

module "app_service_pro" {
  source = "../modules/app_service"

  project             = var.project
  environment         = "pro"
  location            = var.location
  resource_group_name = var.resource_group_name

  ghcr_token_secret_uri = module.keyvault_pro.ghcr_token_secret_uri
  api_key_secret_uri    = module.keyvault_pro.api_key_secret_uri
  jwt_secret_secret_uri = module.keyvault_pro.jwt_secret_secret_uri
}

