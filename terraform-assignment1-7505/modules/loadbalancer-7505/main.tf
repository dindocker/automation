resource "azurerm_public_ip" "lb_pip" {
  name                = "7505-lb-pip"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_lb" "lb" {
  name                = "7505-lb"
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "Standard"
  tags                = var.tags

  frontend_ip_configuration {
    name                 = "lb-frontend"
    public_ip_address_id = azurerm_public_ip.lb_pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "bepool" {
  name                = "7505-lb-backend"
  loadbalancer_id     = azurerm_lb.lb.id
}

resource "azurerm_network_interface_backend_address_pool_association" "nic_assoc" {
  for_each = var.linux_nic_ids

  network_interface_id    = each.value
  ip_configuration_name   = var.linux_ipconfig_names[each.key]
  backend_address_pool_id = azurerm_lb_backend_address_pool.bepool.id
}

resource "azurerm_lb_probe" "probe" {
  name                = "http-probe"
  loadbalancer_id     = azurerm_lb.lb.id
  port                = 80
}

resource "azurerm_lb_rule" "rule" {
  name                           = "http-rule"
  loadbalancer_id                = azurerm_lb.lb.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "lb-frontend"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.bepool.id]
  probe_id                       = azurerm_lb_probe.probe.id
}