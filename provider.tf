    provider "proxmox" {
        endpoint = var.endpoint 
        username = var.pve_user 
        password = var.pvepassword 
        insecure = true 
    ssh {
        agent = true
        username = var.vm_user 
      }
      }

