locals {
  common_tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "Ahmed Ali"
    ExpirationDate = "2026-3-8"
    Environment    = "Learning"
  }

  location = "canadacentral"
}

##### Call rgroup_7505 #####

module "rgroup_7505" {
  source   = "./modules/rgroup-7505"
  rg_name  = "7505-RG"
  location = local.location
  tags     = local.common_tags
}

#### Call network_7505  ####

module "network_7505" {
  source            = "./modules/network-7505"
  rg_name           = module.rgroup_7505.rg_name
  location          = local.location
  tags              = local.common_tags
  vnet_name         = "7505-VNET"
  vnet_address_space = ["10.75.0.0/16"]
  subnet_name       = "7505-SUBNET"
  subnet_prefix     = ["10.75.1.0/24"]
}

##### Call common-7505  ######

module "common_7505" {
  source   = "./modules/common-7505"
  rg_name  = module.rgroup_7505.rg_name
  location = local.location
  tags     = local.common_tags
}

#######  Cal for vmlinux-7505 ######

module "vmlinux_7505" {
  source   = "./modules/vmlinux-7505"
  rg_name  = module.rgroup_7505.rg_name
  location = local.location
  subnet_id = module.network_7505.subnet_id
  tags     = local.common_tags

  boot_diag_storage_endpoint = module.common_7505.storage_account_primary_blob_endpoint

  vm_names = {
    vm1 = "7505-lx-1"
    vm2 = "7505-lx-2"
    vm3 = "7505-lx-3"
  }
}

###### Call for vmwindows-7505  #####

module "vmwindows_7505" {
  source   = "./modules/vmwindows-7505"

  rg_name  = module.rgroup_7505.rg_name
  location = local.location
  tags     = local.common_tags

  subnet_id = module.network_7505.subnet_id

  admin_password = "d1N@unix"  

  boot_diag_storage_endpoint = module.common_7505.storage_account_primary_blob_endpoint
}

####  Call for datadisk_7505 #############

module "datadisk_7505" {
  source   = "./modules/datadisk-7505"
  rg_name  = module.rgroup_7505.rg_name
  location = local.location
  tags     = local.common_tags

  vm_ids = {
    vm1 = module.vmlinux_7505.vm_ids["vm1"]
    vm2 = module.vmlinux_7505.vm_ids["vm2"]
    vm3 = module.vmlinux_7505.vm_ids["vm3"]
    win = module.vmwindows_7505.vm_id
  }
}

#############  Call for loadbalancer_7505  ###############

module "loadbalancer_7505" {
  source   = "./modules/loadbalancer-7505"
  rg_name  = module.rgroup_7505.rg_name
  location = local.location
  tags     = local.common_tags

  linux_nic_ids         = module.vmlinux_7505.nic_ids
  linux_ipconfig_names  = module.vmlinux_7505.ipconfig_names
}

##########  Call for database_7505 #######

module "database_7505" {
  source   = "./modules/database-7505"
  rg_name  = module.rgroup_7505.rg_name
  location = local.location
  tags     = local.common_tags

  admin_password = "d1N@unix"
}