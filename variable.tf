locals {
  os_type                        = "l26"
  datastore_id                   = "zvm"
  ct_datastore_template_location = "local"
  ct_datastore_storage_location  = "local"
  ct_source_file_path            = "http://download.proxmox.com/images/system/debian-12-standard_12.2-1_amd64.tar.zst"
  dns                            = ["192.168.2.10"]
  gateway                        = "192.168.2.1"
  cluster_name                   = "d3cluster"
  bridge                         = "vmbr0"
  disk                           = 10

}
variable "talos-common" {
  type=object({
    node_name         = string
    cluster_name      = string
    vm_id             = number
    cp_cores          = number 
    wk_cores          = number 
    memory            = number
    vm_user           = string
  })
}
variable "talos_ips" {
  type=map(string)
  default = {
    talos_cp_1_ip_addr = ""
    talos_wk_1_ip_addr = ""
  }
  
  }

variable "credentials" {
  type=object({
    endpoint =  string
    pveuser  =  string
    pvepassword = string
    api_token = string
  })
}


#variable "vm_user" {}
#variable "pveuser" {}
#variable "pvepassword" {}
#variable "api_token" {}
#variable "endpoint" {}
variable "project_name" {
  type        = string
  default     = "hl-proj"
}
variable "workspace" {
  type        = string
  default     = "homelab"
}
variable "resource_tags" {
  type        = map(string)
  default     = { } 
}

