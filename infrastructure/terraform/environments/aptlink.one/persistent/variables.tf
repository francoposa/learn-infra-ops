terraform {
  required_version = "~> 1.10"
  required_providers {
    hcloud = {
      source  = "registry.terraform.io/hetznercloud/hcloud"
      version = "~> 1.50"
    }
  }
}
