# Resource: Azure Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "mylinuxvm" {
  name                = "mylinuxvm-1"
  computer_name       = "devlinux-vm1" # Hostname of the VM
  resource_group_name = azurerm_resource_group.myrg.name
  location            = azurerm_resource_group.myrg.location
  size                = "Standard_DC1s_v3"
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.myvmnic.id
  ]

  admin_ssh_key {
    username   = "azureuser"

    public_key = file("C:\\Users\\Administrator\\terraform-practise\\custom-data\\id_rsa.pub")
  }
   os_disk {
    name = "osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "83-gen2"
    version   = "latest"
  }
  custom_data = filebase64("${path.module}/app1-cloud-init.txt")
}