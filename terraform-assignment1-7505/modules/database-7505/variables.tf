variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "admin_user" {
  type    = string
  default = "pgadmin"
}

variable "admin_password" {
  type = string
}