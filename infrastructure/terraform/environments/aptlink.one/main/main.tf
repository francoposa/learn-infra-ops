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

data "hcloud_primary_ip" "aptlink_one_ip_primary_0" {
  name = "aptlink_one_ip_primary_0"
}


resource "hcloud_server" "aptlink_one_node_0" {
  name        = "aptlink.one-node-0"
  image       = "debian-13"
  server_type = "cpx11"
  datacenter  = data.hcloud_datacenter.hil-dc1.name

  public_net {
    ipv4_enabled = true
    ipv4         = data.hcloud_primary_ip.aptlink_one_ip_primary_0.id
    ipv6_enabled = true
  }

  ssh_keys = [
    "id_ed25519_infraops"
  ]

  user_data = file("./cloud-init-debian-container-tools.yaml")
}

