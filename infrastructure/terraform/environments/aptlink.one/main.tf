# Set the variable value in *.tfvars file
# or using the -var="hcloud_token=..." CLI option
variable "hcloud_token" {}

provider "hcloud" {
  token = var.hcloud_token
}

# module "hcloud" {
#   source = "../../modules/hcloud"
# }

data "hcloud_location" "hil" {
  name = "hil"
}

resource "hcloud_floating_ip" "aptlink_one_ip_float_0" {
  name          = "aptlink.one-ip-float-0"
  type          = "ipv4"
  home_location = data.hcloud_location.hil.name
}
