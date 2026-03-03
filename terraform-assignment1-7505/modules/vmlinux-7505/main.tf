resource "azurerm_availability_set" "linux_avs" {
  name                = "7505-Linux-AVS"
  location            = var.location
  resource_group_name = var.rg_name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
  managed                      = true
  tags                         = var.tags
}

resource "azurerm_public_ip" "linux_pip" {
  for_each            = var.vm_names
  name                = "${each.value}-pip"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label = "n${each.value}-dns"
  tags                = var.tags
}

resource "azurerm_network_interface" "linux_nic" {
  for_each            = var.vm_names
  name                = "${each.value}-nic"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "${each.value}-ipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.linux_pip[each.key].id
  }

  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  for_each            = var.vm_names
  name                = each.value
  resource_group_name = var.rg_name
  location            = var.location
  size                = "Standard_D2s_v3"
  admin_username      = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.linux_nic[each.key].id
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.admin_ssh_public_key)
  }

  os_disk {
    name                 = "${each.value}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_2"
    version   = "latest"
  }

  availability_set_id = azurerm_availability_set.linux_avs.id

  boot_diagnostics {
    storage_account_uri = var.boot_diag_storage_endpoint
  }

  tags = var.tags
}