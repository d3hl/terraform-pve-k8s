terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.63.0"
    }
  }
  required_version = ">= 0.6.0"
}

resource "random_string" "resource_code" {
  length  = 5
  special = false
  upper   = false
}

resource "proxmox_virtual_environment_vm" "tf-talos_template" {
  agent {
    enabled = true
  }
  bios        = "ovmf"
  description = "Managed by Terraform"
  cpu {
    cores = 2
    numa  = true
    limit = 64
    # affinity = "0-1"
  }

  smbios {
    manufacturer = "Terraform"
    product      = "Terraform Provider Proxmox"
    version      = "0.0.1"
  }

  startup {
    order      = "3"
    up_delay   = "60"
    down_delay = "60"
  }

  efi_disk {
    datastore_id = local.datastore_id
    file_format  = "raw"
    type         = "4m"
  }

  tpm_state {
    datastore_id = local.datastore_id
    version      = "v2.0"
  }

  disk {
    datastore_id = local.datastore_id
    file_format  = "raw"
    interface    = "ide0"
    size         = 8
  }

  disk {
    datastore_id = local.datastore_id
    file_id      = proxmox_virtual_environment_download_file.latest_debian_12_bookworm_qcow2_img.id
    interface    = "scsi0"
    discard      = "on"
    cache        = "writeback"
    serial	     = "dead_beef"
    ssd          = true
  }


  initialization {
    datastore_id = local.datastore_id
    interface    = "scsi4"

    dns {
      domain = "${var.dns_domain}"
      servers = var.dns 
    }

    ip_config {
      ipv4 {
        address = "dhcp"
      }
      # ipv6 {
      #    address = "dhcp"
      #}
    }

    user_data_file_id   = proxmox_virtual_environment_file.user_config.id
    vendor_data_file_id = proxmox_virtual_environment_file.vendor_config.id
    meta_data_file_id   = proxmox_virtual_environment_file.meta_config.id
  }

  machine = "q35"
  name    = "tf-talos-template"

  cdrom {
    enabled = true
    file_id = "none"
  }

  network_device {
    mtu    = 1450
    queues = 2
  }

  network_device {
    vlan_id = local.vm_id
  }

  node_name = local.node_name

  operating_system {
    type = "l26"
  }

#  pool_id = proxmox_virtual_environment_pool.example.id

  serial_device {}

  vga {
    type = "qxl"
  }

  template = true
}













  cpu {
    cores = 2
  }

  memory {
    dedicated = 2048
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = proxmox_virtual_environment_download_file.ubuntu_cloud_image.id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 20
  }

  initialization {
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.cloud_config.id
  }

  network_device {
    bridge = "vmbr0"
  }

}

resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_image" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = "pve"

  url = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
}

output "vm_ipv4_address" {
  value = proxmox_virtual_environment_vm.ubuntu_vm.ipv4_addresses[1][0]
}