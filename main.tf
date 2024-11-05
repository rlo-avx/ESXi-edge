terraform {
    required_providers {
        equinix = {
            source = "equinix/equinix"
            version = "~>1.10.0" # This is version is necessary due to submodule restrictions
        }
    }
}

provider "equinix" {
    # Or use METAL_AUTH_TOKEN environment variable
    auth_token = "FILL YOUR AUTH TOKEN HERE" # FILL YOUR AUTH TOKEN HERE
}

module "esxi_on_metal" {
    source = "github.com/AviatrixDev/terraform-aviatrix-edge-metal-test-lab.git"

    # required
    metal_project_name = "Support" # FILL YOUR VALID PROJECT NAME HERE
    create_vlan = true
    # optional
    # esxi_hostname = "foo"
}

# Some useful outputs from the above launched module
output "metal_device_ip" {
    description = "VMware ESXi Public IP."
    value       = module.esxi_on_metal.metal_device_ip
}

output "metal_device_password" {
    description = "VMware ESXi password."
    value       = nonsensitive(module.esxi_on_metal.metal_device_password)
}

output "metal_gateway_ip" {
    description = "Metal Gateway IP."
    value       = module.esxi_on_metal.metal_gateway_ip
}

output "public_ip_block" {
    description = "Public IP CIDR block"
    value       = module.esxi_on_metal.public_ip_block
}

output "usable_public_ip" {
    description = "Usable public IP range"
    value       = module.esxi_on_metal.usable_public_ip
}
