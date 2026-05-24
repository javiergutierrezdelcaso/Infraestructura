############################################
# RESOURCE GROUP
############################################

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

############################################
# APP SERVICE PRE (IDENTIDAD)
############################################

module "app_service_pre" {
  source = "./modules/app_service"
  count  = var.environment == "pre" ? 1 : 0

  app_name       = "ecoanalyzer-pre"
  app_env        = "PRE"
  location       = var.location
  resource_group = var.resource_group_name
  sku_name       = var.sku_name
}

############################################
# KEY VAULT PRE
############################################

module "keyvault_pre" {
  source = "./modules/keyvault"
  count  = var.environment == "pre" ? 1 : 0

  project                   = "ecoanalyzer"
  environment               = "pre"
  location                  = var.location
  resource_group_name       = var.resource_group_name
  tenant_id                 = var.arm_tenant_id
  app_identity_principal_id = module.app_service_pre[0].identity_principal_id

  ghcr_token = var.ghcr_token
  api_key    = var.api_key
  jwt_secret = var.jwt_secret
}

############################################
# APP SERVICE PRE (ACTUALIZADO CON SECRETURI)
############################################

module "app_service_pre_update" {
  source = "./modules/app_service"
  count  = var.environment == "pre" ? 1 : 0

  app_name       = "ecoanalyzer-pre"
  app_env        = "PRE"
  location       = var.location
  resource_group = var.resource_group_name
  sku_name       = var.sku_name

  ghcr_token_secret_uri = module.keyvault_pre[0].ghcr_token_secret_uri
  api_key_secret_uri    = module.keyvault_pre[0].api_key_secret_uri
  jwt_secret_secret_uri = module.keyvault_pre[0].jwt_secret_secret_uri
}

############################################
# APP SERVICE PRO (IDENTIDAD)
############################################

module "app_service_pro" {
  source = "./modules/app_service"
  count  = var.environment == "pro" ? 1 : 0

  app_name       = "ecoanalyzer-pro"
  app_env        = "PRO"
  location       = var.location
  resource_group = var.resource_group_name
  sku_name       = var.sku_name
}

############################################
# KEY VAULT PRO
############################################

module "keyvault_pro" {
  source = "./modules/keyvault"
  count  = var.environment == "pro" ? 1 : 0

  project                   = "ecoanalyzer"
  environment               = "pro"
  location                  = var.location
  resource_group_name       = var.resource_group_name
  tenant_id                 = var.arm_tenant_id
  app_identity_principal_id = module.app_service_pro[0].identity_principal_id

  ghcr_token = var.ghcr_token
  api_key    = var.api_key
  jwt_secret = var.jwt_secret
}

############################################
# APP SERVICE PRO (ACTUALIZADO CON SECRETURI)
############################################

module "app_service_pro_update" {
  source = "./modules/app_service"
  count  = var.environment == "pro" ? 1 : 0

  app_name       = "ecoanalyzer-pro"
  app_env        = "PRO"
  location       = var.location
  resource_group = var.resource_group_name
  sku_name       = var.sku_name

  ghcr_token_secret_uri = module.keyvault_pro[0].ghcr_token_secret_uri
  api_key_secret_uri    = module.keyvault_pro[0].api_key_secret_uri
  jwt_secret_secret_uri = module.keyvault_pro[0].jwt_secret_secret_uri
}
