provider "azurerm" {
  features {
    
  }
}
# refer to a resource group
data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

#refer to a subnet
data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.rg_name
}

#create Network interface 
resource "azurerm_network_interface" "Interface" {
  name = "${var.vm_name}-Nic"
  //name                = "${var.info["name"]}-Nic"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name = "${var.vm_name}-IP"
    //name                          = "${var.info["name"]}-IP"
    subnet_id                     = data.azurerm_subnet.subnet.id
    //private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.public.id
    private_ip_address_allocation = "Static"
    private_ip_address = var.vm_ip
  }
}

#create public ip address
resource "azurerm_public_ip" "public" {
  name                    = "${var.vm_name}-PIP"
  location                = data.azurerm_resource_group.rg.location
  resource_group_name     = data.azurerm_resource_group.rg.name
  allocation_method       = "Dynamic"
  
}

# create the  Vm machine 
resource "azurerm_windows_virtual_machine" "vm" {
  name                = var.vm_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  size                = "Standard_F2"
  admin_username      = "vmadmin"
  admin_password      = "Welcome@1234"
  network_interface_ids = [
    azurerm_network_interface.Interface.id,
  ]
# Disk type define here
  os_disk {
    name = "${var.vm_name}-OS-Disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
# os Source 
 source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}
