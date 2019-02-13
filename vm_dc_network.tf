resource "azurerm_public_ip" "vm_dc" {
  count                = "${var.instance_count}"
  name                 = "${var.prefix}_vm_dc_pip"
  location             = "${element(azurerm_resource_group.main.*.location, count.index)}"
  resource_group_name  = "${element(azurerm_resource_group.main.*.name, count.index)}"
  allocation_method    = "Static"
  tags                 = "${var.tags}"
}

resource "azurerm_network_interface" "vm_dc" {
  count                = "${var.instance_count}"
  name                = "${var.prefix}_vm_dc_nic"
  location            = "${element(azurerm_resource_group.main.*.location, count.index)}"
  resource_group_name = "${element(azurerm_resource_group.main.*.name, count.index)}"
  tags                = "${var.tags}"

  ip_configuration {
    name                          = "${var.prefix}_configuration"
    subnet_id                     = "${element(azurerm_subnet.internal.*.id, count.index)}"
    private_ip_address_allocation = "Static"
    private_ip_address            = "${cidrhost("192.168.8.0/24", 10)}"
    public_ip_address_id          = "${element(azurerm_public_ip.vm_dc.*.id, count.index)}"
  }
}
