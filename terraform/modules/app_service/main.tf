resource "azurerm_service_plan" "plan" {
  name                = "asp-${var.app_name}"
  location            = var.location
  resource_group_name = var.resource_group
  os_type             = "Linux"
  sku_name            = var.sku_name
}

resource "azurerm_linux_web_app" "app" {
  name                = var.app_name
  location            = var.location
  resource_group_name = var.resource_group
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {
    application_stack {
      dotnet_version = "8.0"
    }

    # ✅ CKV_AZURE_14 – forzar HTTPS
    redirect_http_to_https = true

    # ✅ CKV_AZURE_78 – deshabilitar FTP
    ftps_state = "Disabled"

    # ✅ CKV_AZURE_213 – health check
    health_check_path = "/"
  }

  app_settings = {
    "APP_ENV" = var.app_env
  }
}
