############################################
# SERVICE PLAN
############################################

resource "azurerm_service_plan" "plan" {
  name                = "asp-${var.app_name}"
  location            = var.location
  resource_group_name = var.resource_group
  os_type             = "Linux"
  sku_name            = var.sku_name
}

############################################
# USER ASSIGNED MANAGED IDENTITY
############################################

resource "azurerm_user_assigned_identity" "identity" {
  name                = "id-${var.app_name}"
  location            = var.location
  resource_group_name = var.resource_group
}

############################################
# LINUX WEB APP
############################################

resource "azurerm_linux_web_app" "app" {
  name                = var.app_name
  location            = var.location
  resource_group_name = var.resource_group
  service_plan_id     = azurerm_service_plan.plan.id

  https_only = true

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.identity.id]
  }

  site_config {
    application_stack {
      dotnet_version = "8.0"
    }
    ftps_state                        = "Disabled"
    health_check_path                 = "/"
    health_check_eviction_time_in_min = 10
  }

  app_settings = {
    APP_ENV = var.app_env

    GHCR_TOKEN = var.ghcr_token_secret_uri != null ?
      "@Microsoft.KeyVault(SecretUri=${var.ghcr_token_secret_uri})" : null

    API_KEY = var.api_key_secret_uri != null ?
      "@Microsoft.KeyVault(SecretUri=${var.api_key_secret_uri})" : null

    JWT_SECRET = var.jwt_secret_secret_uri != null ?
      "@Microsoft.KeyVault(SecretUri=${var.jwt_secret_secret_uri})" : null
  }
}

