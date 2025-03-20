resource "azurerm_resource_group" "res_grp" {
  name = var.res_grp_name
  location = var.location
}

resource "azurerm_virtual_network" "virt_net"{
  name = var.virt_net_name
  location = azurerm_resource_group.res_grp.location
  resource_group_name = azurerm_resource_group.res_grp.name
  address_space = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet"{
  name = var.sub_name
  resource_group_name = azurerm_resource_group.res_grp.name
  virtual_network_name = azurerm_virtual_network.virt_net.name
  address_prefixes =  ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "net_int" {
  name = "my-net-int"
  location = azurerm_resource_group.res_grp.location
  resource_group_name = azurerm_resource_group.res_grp.name
  
  ip_configuration {
    name = "internal"
    subnet_id = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "my_vm" {
  name = var.vm_name
  location = azurerm_resource_group.res_grp.location
  resource_group_name = azurerm_resource_group.res_grp.name
  network_interface_ids = [azurerm_network_interface.net_int.id]
  vm_size = "Standard_B1s"

  storage_os_disk {
    name = "osdisk"
    caching = "ReadWrite"
    create_option = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer = "UbuntuServer"
    sku = "18.04-LTS"
    version = "latest"
  }

  os_profile {
    computer_name = var.vm_name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}