

variable "subscription_id" {
    default = "49dcc0cb-6eb4-40a7-a55b-d11c38d52a42"
}
variable "client_id" {
    default = "1450ba7e-8830-490c-bdbe-eacea82b5d9e"
}
variable "client_secret" {
    default = "JC26rqttIpUQpLhFW7SS17hKKC/7fCMddWIOkv+qi1k="
}
variable "tenant_id" {
    default = "dc2f5a8b-f363-40f3-aa3c-15817fa15cca"
}

variable "prefix" {
  default = "terratest1"
  description = "The Prefix used for all resources in this example"
}

variable "location" {
  default = "West Europe"
  description = "The Azure Region in which the resources in this example should exist"
}

variable "tags" {
  type        = "map"
  default     = {
      environment = "terratest1"
  }
  description = "Any tags which should be assigned to the resources in this example"
}

variable "vm_username" {
    default = "demoadmin"
}
variable "vm_password" {
    default = "Passw0rd#NobodyKnows"
}

variable "dns_domain_name" {
    default = "dt.local"
}

variable "domain_netbios_name" {
    default = "DT"
}
variable "instance_count" {
    default = 3
}
