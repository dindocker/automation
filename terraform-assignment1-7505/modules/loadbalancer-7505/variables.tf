variable "rg_name" { type = string }
variable "location" { type = string }
variable "tags" { type = map(string) }

variable "linux_nic_ids" {
  type = map(string)
}

variable "linux_ipconfig_names" {
  type = map(string)
}