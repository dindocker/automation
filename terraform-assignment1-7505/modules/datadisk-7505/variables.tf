variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vm_ids" {
  description = "Map of VM IDs to attach disks to"
  type        = map(string)
}

variable "tags" {
  type = map(string)
}