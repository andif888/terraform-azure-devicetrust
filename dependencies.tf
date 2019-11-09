provider "azurerm" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  version = "~> 1.27"

  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"

}

terraform {
  backend "azurerm" {
  }
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "main" {
  count    = "${var.instance_count}"
  name     = "${var.prefix}_resources_${count.index}"
  location = "${var.location}"
  tags     = "${var.tags}"
}

resource "azurerm_virtual_network" "main" {
  count               = "${var.instance_count}"
  name                = "${var.prefix}_network"
  address_space       = ["192.168.8.0/24"]
  location            = "${element(azurerm_resource_group.main.*.location, count.index)}"
  resource_group_name = "${element(azurerm_resource_group.main.*.name, count.index)}"
  tags                = "${var.tags}"
}

resource "azurerm_subnet" "internal" {
  count                = "${var.instance_count}"
  name                 = "internal"
  resource_group_name  = "${element(azurerm_resource_group.main.*.name, count.index)}"
  virtual_network_name = "${element(azurerm_virtual_network.main.*.name, count.index)}"
  address_prefix       = "192.168.8.0/24"
}
