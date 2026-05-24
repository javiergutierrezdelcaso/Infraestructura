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

  subnet_id = azurerm_subnet.kv_subnet.id
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

  subnet_id = azurerm_subnet.kv_subnet_pro.id
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

resource "azurerm_network_security_group" "kv_nsg_pre" {
  name                = "${var.project}-pre-kv-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.pre.name
}

resource "azurerm_subnet" "kv_subnet" {
  name                 = "kv-subnet"
  resource_group_name  = azurerm_resource_group.pre.name
  virtual_network_name = azurerm_virtual_network.kv_vnet.name
  address_prefixes     = ["10.10.1.0/24"]

  private_endpoint_network_policies_enabled = true
}

resource "azurerm_subnet_network_security_group_association" "kv_subnet_nsg_pre" {
  subnet_id                 = azurerm_subnet.kv_subnet.id
  network_security_group_id = azurerm_network_security_group.kv_nsg_pre.id
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

###############################################
# NETWORKING FOR PRIVATE ENDPOINT (PRO)
###############################################

resource "azurerm_virtual_network" "kv_vnet_pro" {
  name                = "${var.project}-pro-vnet"
  location            = var.location
  resource_group_name = azurerm_resource_group.pro.name
  address_space       = ["10.20.0.0/16"]
}

resource "azurerm_network_security_group" "kv_nsg_pro" {
  name                = "${var.project}-pro-kv-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.pro.name
}

resource "azurerm_subnet" "kv_subnet_pro" {
  name                 = "kv-subnet-pro"
  resource_group_name  = azurerm_resource_group.pro.name
  virtual_network_name = azurerm_virtual_network.kv_vnet_pro.name
  address_prefixes     = ["10.20.1.0/24"]

  private_endpoint_network_policies_enabled = true
}

resource "azurerm_subnet_network_security_group_association" "kv_subnet_nsg_pro" {
  subnet_id                 = azurerm_subnet.kv_subnet_pro.id
  network_security_group_id = azurerm_network_security_group.kv_nsg_pro.id
}

resource "azurerm_private_dns_zone" "kv_dns_pro" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = azurerm_resource_group.pro.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "kv_dns_link_pro" {
  name                  = "kv-dns-link-pro"
  resource_group_name   = azurerm_resource_group.pro.name
  private_dns_zone_name = azurerm_private_dns_zone.kv_dns_pro.name
  virtual_network_id    = azurerm_virtual_network.kv_vnet_pro.id
}
