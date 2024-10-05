resource "proxmox_virtual_environment_vm" "talos_cp_01" {
  name        = "talos-cp-01"
  description = "Managed by Terraform"
  tags        = ["terraform"]
  node_name   = var.talos-common.node_name 
  on_boot     = true

  cpu {
    cores = var.talos-common.cp_cores
    type = "x86-64-v2-AES"
  }

  memory {
    dedicated = var.talos-common.memory
  }

  agent {
    enabled = true
  }

  network_device {
    bridge = var.locals.bridge
  }

  disk {
    datastore_id = local.datastore_id
    file_id      = proxmox_virtual_environment_download_file.talos_nocloud_image.id
    file_format  = "raw"
    interface    = "virtio0"
    size         = 20
  }

  operating_system {
    type = locals.os_type 
  }

  initialization {
    datastore_id = local.datastore_id
    ip_config {
      ipv4 {
        address = "${var.talos_cp_01_ip_addr}/24"
        gateway = locals.gateway
      }
    }
  }
}

resource "proxmox_virtual_environment_vm" "talos_wk_01" {
  depends_on = [ proxmox_virtual_environment_vm.talos_cp_01 ]
  name        = "talos-wk-01"
  description = "Managed by Terraform"
  tags        = ["terraform","talos","k8s"]
  node_name   = var.talos-common.node_name
  on_boot     = true

  cpu {
    cores = var.talos-common.wk_cores
    type = "x86-64-v2-AES"
  }

  memory {
    dedicated = var.talos-common.memory
  }

  agent {
    enabled = true
  }

  network_device {
    bridge = local.bridge
  }

  disk {
    datastore_id = local.datastore_id
    file_id      = proxmox_virtual_environment_download_file.talos_nocloud_image.id
    file_format  = "raw"
    interface    = "virtio0"
    size         = 20
  }

  operating_system {
    type = locals.os_type
  }

  initialization {
    datastore_id = local.datastore_id
    ip_config {
      ipv4 {
        address = "${var.talos_wk_01_ip_addr}/24"
        gateway = locals.gateway
      }
      ipv6 {
        address = "dhcp"
      }
    }
  }
}