# Set the variable value in *.tfvars file
# or using the -var="hcloud_token=..." CLI option
variable "hcloud_token" {}

provider "hcloud" {
  token = var.hcloud_token
}

data "hcloud_location" "location" {
  name = var.location_name
}

data "hcloud_datacenter" "datacenter" {
  name = var.datacenter_name
}

output "hcloud_location_datacenter" {
  value = {
    location   = data.hcloud_location.location
    datacenter = data.hcloud_datacenter.datacenter
  }
}

# output "location" {
#   value = data.hcloud_location.location
# }
#
# output "datacenter" {
#   value = data.hcloud_datacenter.datacenter
# }
