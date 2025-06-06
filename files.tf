locals {
  talos = {
    version = "v1.8.1"
  }
}

resource "proxmox_virtual_environment_download_file" "talos_nocloud_image" {
  content_type            = "iso"
  datastore_id            = "local"
  node_name               = var.talos-common.node_name

  #file_name               = "talos-${local.talos.version}-nocloud-amd64.iso"
  file_name               = "talos-v1.8.1-nocloud-amd64.iso"
  #url                     = "https://factory.talos.dev/image/ce4c980550dd2ab1b17bbf2b08801c7eb59418eafe8f279833297925d67c7515/${local.talos.version}/nocloud-amd64.iso" 
  url                     = "https://factory.talos.dev/image/ce4c980550dd2ab1b17bbf2b08801c7eb59418eafe8f279833297925d67c7515/v1.8.1/nocloud-amd64.raw.xz"
  decompression_algorithm = "gz"
  overwrite               = false
}