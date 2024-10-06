    provider "proxmox" {
        endpoint = var.endpoint 
        username = var.pveuser 
        password = var.pvepassword
        api_token = var.api_token
        insecure = true 
    ssh {
        agent = true
        username = var.vm_user 
      }
      }

