###############################################
# RESOURCE GROUPS
###############################################

resource "azurerm_resource_group" "pre" {
  name     = "${var.project}-pre-rg"
  location = var.location
}

resource "azurerm_resource_group" "pro" {
  name     = "${var.project}-pro-rg"
  location = var.location
}

###############################################
# KEY VAULT PRE
###############################################

module "keyvault_pre" {
  source = "./modules/keyvault"

  project             = var.project
  environment         = "pre"
  location            = var.location
  resource_group_name = azurerm_resource_group.pre.name
  tenant_id           = var.arm_tenant_id

  ghcr_token = var.ghcr_token
  api_key    = var.api_key
  jwt_secret = var.jwt_secret

  allowed_ip_ranges       = []
  secrets_expiration_date = "2026-12-31T00:00:00Z"
}

###############################################
# KEY VAULT PRO
###############################################

module "keyvault_pro" {
  source = "./modules/keyvault"

  project             = var.project
  environment         = "pro"
  location            = var.location
  resource_group_name = azurerm_resource_group.pro.name
  tenant_id           = var.arm_tenant_id

  ghcr_token = var.ghcr_token
  api_key    = var.api_key
  jwt_secret = var.jwt_secret

  allowed_ip_ranges       = []
  secrets_expiration_date = "2026-12-31T00:00:00Z"
}

###############################################
# APP SERVICE PRE
###############################################

module "app_service_pre" {
  source = "./modules/app_service"

  project             = var.project
  environment         = "pre"
  location            = var.location
  resource_group_name = azurerm_resource_group.pre.name
}

###############################################
# APP SERVICE PRO
###############################################

module "app_service_pro" {
  source = "./modules/app_service"

  project             = var.project
  environment         = "pro"
  location            = var.location
  resource_group_name = azurerm_resource_group.pro.name
}

###############################################
# NETWORKING FOR PRIVATE ENDPOINT (PRE)
###############################################

resource "azurerm_virtual_network" "kv_vnet" {
  name                = "${var.project}-pre-vnet"
  location            = var.location
  resource_group_name = azurerm_resource_group.pre.name
  address_space       = ["10.10.0.0/16"]
}

resource "azurerm_subnet" "kv_subnet" {
  name                 = "kv-subnet"
  resource_group_name  = azurerm_resource_group.pre.name
  virtual_network_name = azurerm_virtual_network.kv_vnet.name
  address_prefixes     = ["10.10.1.0/24"]

  private_endpoint_network_policies_enabled = true
}

resource "azurerm_private_dns_zone" "kv_dns" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = azurerm_resource_group.pre.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "kv_dns_link" {
  name                  = "kv-dns-link"
  resource_group_name   = azurerm_resource_group.pre.name
  private_dns_zone_name = azurerm_private_dns_zone.kv_dns.name
  virtual_network_id    = azurerm_virtual_network.kv_vnet.id
}

resource "azurerm_private_endpoint" "kv_pe" {
  name                = "${var.project}-pre-kv-pe"
  location            = var.location
  resource_group_name = azurerm_resource_group.pre.name
  subnet_id           = azurerm_subnet.kv_subnet.id

  private_service_connection {
    name                           = "kv-connection"
    private_connection_resource_id = module.keyvault_pre.key_vault_id
    subresource_names              = ["vault"]
    is_manual_connection           = false
  }
}

