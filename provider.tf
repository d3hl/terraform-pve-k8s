    provider "proxmox" {
        endpoint = var.credentials.endpoint
        username = var.credentials.pveuser 
        password = var.credentials.pvepassword
        api_token = var.credentials.api_token
        insecure = true 
    ssh {
        agent = true
        username = var.vm_user 
      }
      }

