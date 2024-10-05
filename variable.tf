locals {
  os_type                        ="l26"
  datastore_id                   = "zvm"
  ct_datastore_template_location = "local"
  ct_datastore_storage_location  = "local"
  ct_source_file_path            = "http://download.proxmox.com/images/system/debian-12-standard_12.2-1_amd64.tar.zst"
  dns                            = ["192.168.2.10"]
  gateway                        = "192.168.2.1"
  cluster_name                   = "d3cluster"
  bridge                      = "vmbr0"
  cp_cores                          = 2 
  wk_cores                          = 4 
  disk                           = 10
  memory                         = 4096

}
variable "talos-common" {
  type=object({
    node_name = string
    vm_id = number
    cp_cores                          = 2 
    wk_cores                          = 4 
    memory                         = 4096
  })
}
variable "talos_ips" {
  type=map(string)
  default = {
    talos_cp_01_ip_addr = ""
    talos_wk_01_ip_addr = ""
  }
  
  }

variable "vm_user" {}
variable "pveuser" {}
variable "pvepassword" {}
variable "api_token" {}
variable "project_name" {
  type        = string
  default     = "ncdv-hl"
}
variable "workspace" {
  type        = string
  default     = "d3-homelab"
}
variable "resource_tags" {
  type        = map(string)
  default     = { } 
}

