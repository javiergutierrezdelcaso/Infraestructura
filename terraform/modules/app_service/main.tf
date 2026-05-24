resource "azurerm_service_plan" "this" {
  name                = "asp-${var.project}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = var.sku_name
}

resource "azurerm_linux_web_app" "this" {
  name                = "${var.project}-${var.environment}-app"
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.this.id

  https_only = true

  site_config {
    always_on = true
    ftps_state = "Disabled"
    health_check_path = "/health"
  }
}
