terraform {
  required_version = "~> 1.10"
  required_providers {
    hcloud = {
      source  = "registry.terraform.io/hetznercloud/hcloud"
      version = "~> 1.50"
    }
  }
}

variable "location_name" {
  type = string
}

variable "datacenter_name" {
  type = string
}
