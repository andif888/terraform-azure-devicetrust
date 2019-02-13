locals {
  computer_name_ctrl = "ctrl"
  
}

resource "azurerm_virtual_machine" "vm_controller" {
  count                 = "${var.instance_count}"
  name                  = "${var.prefix}_vm_controller"
  location              = "${element(azurerm_resource_group.main.*.location, count.index)}"
  resource_group_name   = "${element(azurerm_resource_group.main.*.name, count.index)}"
  network_interface_ids = ["${element(azurerm_network_interface.vm_controller.*.id, count.index)}"]
  vm_size               = "Standard_B1ms"

  # This means the OS Disk will be deleted when Terraform destroys the Virtual Machine
  # NOTE: This may not be optimal in all cases.
  delete_os_disk_on_termination = true

  # This means the Data Disk Disk will be deleted when Terraform destroys the Virtual Machine
  # NOTE: This may not be optimal in all cases.
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.prefix}_vm_controller_osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "${local.computer_name_ctrl}"
    admin_username = "${var.vm_username}"
    admin_password = "${var.vm_password}"
  }

  os_profile_linux_config {
    disable_password_authentication = false

    ssh_keys {
      path     = "/home/${var.vm_username}/.ssh/authorized_keys"
      key_data = "${file("~/.ssh/id_rsa.pub")}"
    }
  }

  connection {
      type = "ssh"
      user = "${var.vm_username}"
      password = "${var.vm_password}"
  }

  provisioner "file" {
    source = "scripts"
    destination = "/tmp"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod -R +x /tmp/scripts",
      "/tmp/scripts/prepare_controller.sh",
    ]
  }

  provisioner "file" {
    source = "ansible"
    destination = "/tmp"
  }

  provisioner "remote-exec" {
    inline = [
      "cd /tmp/ansible",
      "ansible-galaxy install -v -r requirements.yml -p ./roles/",
      "ansible-playbook -i inventory site.yml --extra-vars 'ansible_user=${var.vm_username} ansible_password=${var.vm_password} domain_admin_user=${var.vm_username}@${var.dns_domain_name} domain_admin_password=${var.vm_password} safe_mode_password=${var.vm_password}'",
    ]
  }

  depends_on = ["azurerm_virtual_machine.vm_dc", "azurerm_virtual_machine.vm_rdsh", "azurerm_virtual_machine.vm_client", "azurerm_virtual_machine.vm_byod"]


  tags = "${var.tags}"
}