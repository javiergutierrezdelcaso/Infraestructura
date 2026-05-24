resource "azurerm_service_plan" "this" {
  name                = "asp-${var.project}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = var.sku_name
}

# checkov:skip=CKV_AZURE_225: Zone redundancy no disponible en Azure for Students
# checkov:skip=CKV_AZURE_212: Failover requiere plan Premium
# checkov:skip=CKV_AZURE_211: App Service Plan de producción no disponible
# checkov:skip=CKV_AZURE_65: Detailed errors requieren plan Standard
# checkov:skip=CKV_AZURE_63: HTTP logging requiere plan Standard
# checkov:skip=CKV_AZURE_66: Failed request tracing requiere plan Standard
# checkov:skip=CKV_AZURE_222: PNA no puede deshabilitarse en F1/B1
# checkov:skip=CKV_AZURE_13: App Service Authentication requiere Azure AD
# checkov:skip=CKV_AZURE_71: Managed Identity no disponible en Azure for Students
# checkov:skip=CKV_AZURE_18: HTTP version latest requiere config avanzada
# checkov:skip=CKV_AZURE_88: Azure Files requiere Storage Account
# checkov:skip=CKV_AZURE_16: Azure AD registration requiere permisos de tenant
# checkov:skip=CKV_AZURE_17: mTLS no aplicable en F1
resource "azurerm_linux_web_app" "this" {

  name                = "${var.project}-${var.environment}-app"
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.this.id

  https_only = true

  site_config {
    always_on  = true
    ftps_state = "Disabled"

    # Health check (AzureRM 4.x exige ambos)
    health_check_path                 = "/health"
    health_check_eviction_time_in_min = 2
  }
}
