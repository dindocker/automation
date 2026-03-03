variable "rg_name" {
  type        = string
  description = "Resource group name for Windows VM resources"
}

variable "location" {
  type        = string
  description = "Azure region for Windows VM resources"
}

variable "tags" {
  type        = map(string)
  description = "Common tags for Windows resources"
}

variable "win_avs" {
  description = "Name of the Windows availability set"
  type        = string
  default     = "7505-windows-avs"
}

variable "nb_count" {
  description = "Number of Windows VMs to create"
  type        = number
  default     = 1   # assignment: 1 VM, but still scalable
}

variable "win_name" {
  description = "Base name for Windows VMs"
  default     = "7505-winvm"
}

variable "win_size" {
  description = "Windows VM size"
  default     = "Standard_D2s_v3"   # I change assignment requirement from "Standard_B1ms"
}

variable "admin_username" {
  description = "Admin username for Windows VM"
  default     = "n10007505"
}

variable "admin_password" {
  description = "Admin password for Windows VM"
  type        = string
}

variable "os_disk_type" {
  description = "OS disk storage type"
  default     = "Standard_LRS"
}

variable "os_disk_size" {
  description = "OS disk size in GB"
  default     = 128
}

variable "os_disk_caching" {
  description = "OS disk caching mode"
  default     = "ReadWrite"
}

variable "win_publisher" {
  description = "Windows image publisher"
  default     = "MicrosoftWindowsServer"
}

variable "win_offer" {
  description = "Windows image offer"
  default     = "WindowsServer"
}

variable "win_sku" {
  description = "Windows image SKU"
  default     = "2016-Datacenter"   # assignment: Windows Server 2016
}

variable "win_version" {
  description = "Windows image version"
  default     = "latest"
}

variable "subnet_id" {
  description = "Subnet ID for Windows NICs"
  type        = string
}

variable "boot_diag_storage_endpoint" {
  description = "Storage account blob endpoint for boot diagnostics"
  type        = string
}