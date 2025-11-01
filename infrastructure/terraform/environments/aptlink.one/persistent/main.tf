# Set the variable value in *.tfvars file
# or using the -var="hcloud_token=..." CLI option
variable "hcloud_token" {}

provider "hcloud" {
  token = var.hcloud_token
}

data "hcloud_location" "hil" {
  name = "hil"
}

data "hcloud_datacenter" "hil-dc1" {
  name = "hil-dc1"
}

resource "hcloud_primary_ip" "aptlink_one_ip_primary_0" {
  name              = "aptlink_one_ip_primary_0"
  datacenter        = data.hcloud_datacenter.hil-dc1.name
  type              = "ipv4"
  assignee_type     = "server"
  auto_delete       = false
  delete_protection = true
  lifecycle {
    prevent_destroy = true
  }
}

