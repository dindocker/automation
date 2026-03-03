output "rg_name" {
  value = module.rgroup_7505.rg_name
}

output "vnet_name" {
  value = module.network_7505.vnet_name
}

output "linux_vm_hostnames" {
  value = module.vmlinux_7505.hostnames
}

output "linux_vm_fqdns" {
  value = module.vmlinux_7505.fqdns
}

output "linux_private_ips" {
  value = module.vmlinux_7505.private_ips
}

output "linux_public_ips" {
  value = module.vmlinux_7505.public_ips
}

output "windows_vm_hostnames" {
  value = module.vmwindows_7505.vm_hostnames
}

output "windows_vm_fqdns" {
  value = module.vmwindows_7505.vm_fqdns
}

output "windows_private_ips" {
  value = module.vmwindows_7505.private_ips
}

output "windows_public_ips" {
  value = module.vmwindows_7505.public_ips
}
# ...and so on for  load balancer, database, etc.