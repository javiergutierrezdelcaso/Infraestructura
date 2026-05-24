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

  https_only = true   # CKV_AZURE_14

  site_config {
    ftps_state        = "Disabled"   # CKV_AZURE_78
    health_check_path = "/health"    # CKV_AZURE_213
  }
}

output "app_url" {
  value = azurerm_linux_web_app.this.default_hostname
}
