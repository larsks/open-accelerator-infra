terraform {
  required_version = ">= 1.9.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.53.0"
    }
  }
}

provider "openstack" {
  cloud = "open-accelerator"
}

provider "openstack" {
  alias = "admin"
  cloud = "moc-esi-admin"
}

variable "boot_image" {
  type    = string
  default = "https://fedora.mirror.constant.com/fedora/linux/releases/44/Server/x86_64/iso/Fedora-Server-netinst-x86_64-44-1.7.iso"
}
