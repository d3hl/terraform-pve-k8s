terraform {
  
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.73.0"
    }
    talos = {
      source = "siderolabs/talos"
      version = "0.5.0"
    }
  }

  required_version = ">= 0.6.0"
}