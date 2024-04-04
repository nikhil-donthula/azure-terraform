environment                     = "dev"
team                            = "eng"
location                        = "westus"
resource_group                  = "nikhil-eng-dev-wusrg"
vnet_address_space              = "192.168.80.0/20"
private_subnet_address_prefixes = "192.168.94.0/24"
public_subnet_address_prefixes  = "192.168.95.0/24"
vm_name = "backend-eng-dev"
app_service_name = "frontend-eng-dev"



tags = {
  environment = "dev"
  managed_by  = "terraform"
  created_by  = "nikhil-donthula"
  team        = "engineering"
}