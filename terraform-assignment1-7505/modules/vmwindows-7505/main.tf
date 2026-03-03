# Availability Set
resource "azurerm_availability_set" "win_avs" {
  name                = var.win_avs
  location            = var.location
  resource_group_name = var.rg_name

  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
  managed                      = true
  tags                         = var.tags
}

# Public IPs
resource "azurerm_public_ip" "win_pip" {
  count               = var.nb_count

  name                = "${var.win_name}-pip-${count.index}"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"

domain_name_label = "win${var.win_name}-${count.index}-dns"
  tags              = var.tags
}

# Network Interfaces
resource "azurerm_network_interface" "win_nic" {
  count               = var.nb_count

  name                = "${var.win_name}-nic-${count.index}"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "${var.win_name}-ipconfig-${count.index}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.win_pip[count.index].id
  }

  tags = var.tags
}

# Windows Virtual Machines
resource "azurerm_windows_virtual_machine" "win_vm" {
  count               = var.nb_count

  name                = "${var.win_name}-${count.index}"
  computer_name       = "winvm${count.index}"
  resource_group_name = var.rg_name
  location            = var.location
  size                = var.win_size

  admin_username = var.admin_username
  admin_password = var.admin_password

  network_interface_ids = [
    azurerm_network_interface.win_nic[count.index].id
  ]

  os_disk {
    name                 = "${var.win_name}-os-disk-${count.index}"
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_type
  }

  source_image_reference {
    publisher = var.win_publisher
    offer     = var.win_offer
    sku       = var.win_sku
    version   = var.win_version
  }

  availability_set_id = azurerm_availability_set.win_avs.id

  boot_diagnostics {
    storage_account_uri = var.boot_diag_storage_endpoint
  }

  tags = var.tags
}