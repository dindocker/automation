# automation
automation first assignment

How to Deploy
1. Initialize Terraform
terraform init
2. Validate configuration
terraform validate
3. Preview changes
terraform plan
4. Apply the deployment
terraform apply --auto-approve
5. list the state
terraform state list | nl
6. terraform output
7. Destroy the environment
terraform destroy

Outputs
The deployment provides:
•	Linux VM hostnames, private IPs, public IPs, and FQDNs
•	Windows VM hostname, private IP, public IP, and FQDN
•	Resource group name
•	VNet name
