output "public_ip_address_vm_controller" {
  value = "${azurerm_public_ip.vm_controller.*.ip_address}"
}

output "public_ip_address_vm_dc" {
  value = "${azurerm_public_ip.vm_dc.*.ip_address}"
}

output "public_ip_address_vm_rdsh" {
  value = "${azurerm_public_ip.vm_rdsh.*.ip_address}"
}

output "public_ip_address_vm_client" {
  value = "${azurerm_public_ip.vm_client.*.ip_address}"
}

output "public_ip_address_vm_byod" {
  value = "${azurerm_public_ip.vm_byod.*.ip_address}"
}

#output "ssh_command" {
#  value = "ssh ${local.admin_username}@${azurerm_public_ip.main.*.ip_address}"
#}