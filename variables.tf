variable "azure_client_id" {}

variable "azure_client_secret" {}

variable "azure_subscription_id" {}

variable "azure_tenant_id" {}

variable "res_grp_name" {
    default = "rg-24072"
}

variable "location" {
    default = "East US"
}

variable "virt_net_name" {
    default = "vnet-24072"
}

variable "sub_name" {
    default = "subnet-24072"
}

variable "vm_name" {
    default = "vm-24072"
}

variable "admin_username" {
    default = "azureuser"
}

variable "admin_password" {}