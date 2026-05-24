resource "azurerm_service_plan" "this" {
  name                = "${var.project}-${var.environment}-plan"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "this" {
  name                = "${var.project}-${var.environment}-app"
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.this.id

  https_only = true

  site_config {
    ftps_state          = "Disabled"
    always_on           = true
    minimum_tls_version = "1.2"
    health_check_path   = "/health"
  }

  app_settings = {
    GHCR_TOKEN = "@Microsoft.KeyVault(SecretUri=${var.ghcr_token_secret_uri})"
    API_KEY    = "@Microsoft.KeyVault(SecretUri=${var.api_key_secret_uri})"
    JWT_SECRET = "@Microsoft.KeyVault(SecretUri=${var.jwt_secret_secret_uri})"
  }
}

output "app_url" {
  value = azurerm_linux_web_app.this.default_hostname
}
