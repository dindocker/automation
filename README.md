# automation
automation first assignment

Terraform Azure Assignment – 7505
This project provisions a complete Azure environment using Terraform. The deployment includes Linux and Windows virtual machines, a load balancer, PostgreSQL Flexible Server, networking, storage, monitoring, and data disks — all orchestrated through reusable Terraform modules.

Architecture Overview
The environment includes:
  •	Resource Group
  •	Virtual Network + Subnet
  •	Network Security Group + Rules
  •	Three Linux VMs (CentOS) in an Availability Set
  •	One Windows VM in an Availability Set
  •	Standard Load Balancer with: 
    -	Public IP
    -	Backend pool
    -	Health probe
    -	Load balancing rule (port 80)
•	Public IPs + FQDNs for all VMs
•	PostgreSQL Flexible Server
•	Data Disks attached to all VMs
•	Log Analytics Workspace
•	Recovery Services Vault
•	Storage Account for boot diagnostics
All resources are deployed using Terraform modules for clarity, reusability, and maintainability.

Repository Structure
terraform-assignment1-7505/
│
├── main.tf
├── providers.tf
├── backend.tf
├── outputs.tf
├── .gitignore
│
└── modules/
    ├── rgroup-7505/
    ├── network-7505/
    ├── common-7505/
    ├── vmlinux-7505/
    ├── vmwindows-7505/
    ├── loadbalancer-7505/
    ├── datadisk-7505/
    └── database-7505/
Each module contains its own main.tf, variables.tf, and outputs.tf.

Module Descriptions
Resource Group Module
Creates the main Azure resource group for all resources.
Network Module
Deploys:
•	Virtual Network
•	Subnet
•	Network Security Group
•	NSG association
Common Module
Creates shared infrastructure:
•	Storage Account
•	Log Analytics Workspace
•	Recovery Services Vault
Linux VM Module
Deploys 3 Linux VMs with:
•	Availability Set
•	NICs + Public IPs
•	SSH key authentication
•	Boot diagnostics
•	Custom hostname provisioning
Windows VM Module
Deploys 1 Windows VM with:
•	Availability Set
•	NIC + Public IP
•	Antimalware extension
•	Boot diagnostics
Load Balancer Module
Creates:
•	Standard Public IP
•	Load Balancer
•	Backend pool
•	Health probe
•	Load balancing rule
•	NIC backend associations
Data Disk Module
Creates and attaches:
•	3 Linux data disks
•	1 Windows data disk
Database Module
Deploys:
•	PostgreSQL Flexible Server
•	General Purpose SKU
•	Public access enabled
•	No availability zone (to avoid Azure restrictions)

**How to Deploy
1. Initialize Terraform
terraform init
2. Validate configuration
terraform validate
3. Preview changes
terraform plan
4. Apply the deployment
terraform apply --auto-approve
5. Destroy the environment (optional)
terraform destroy

Outputs
The deployment provides:
•	Linux VM hostnames, private IPs, public IPs, and FQDNs
•	Windows VM hostname, private IP, public IP, and FQDN
•	Resource group name
•	VNet name
These outputs help with SSH/RDP access and load balancer testing.
