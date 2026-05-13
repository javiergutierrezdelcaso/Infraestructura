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

  https_only = true

  site_config {
    application_stack {
      dotnet_version = "8.0"
    }

    ftps_state                     = "Disabled"
    health_check_path              = "/"
    health_check_eviction_time_in_min = 10
  }

  app_settings = {
    APP_ENV = var.app_env
  }
}