variable "rg_name" { type = string }
variable "location" { type = string }
variable "subnet_id" { type = string }
variable "tags" { type = map(string) }

variable "boot_diag_storage_endpoint" {
  type = string
}

variable "vm_names" {
  type = map(string)
  # e.g. { vm1 = "7505-lx-1", vm2 = "7505-lx-2", vm3 = "7505-lx-3" }
}

variable "admin_username" {
  type    = string
  default = "n10007505"
}

variable "admin_ssh_public_key" {
  type    = string
  default = "/home/n10007505/.ssh/id_rsa_azure.pub"
}

variable "admin_ssh_private_key" {
  type    = string
  default = "/home/n10007505/.ssh/id_rsa_azure"
}