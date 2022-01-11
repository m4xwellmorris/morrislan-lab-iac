resource "xenorchestra_vm" "xorch-lab" {
  memory_max = 4294967296
  cpus = 2
  name_label = "xorch-lab"
  template = data.xenorchestra_template.ubuntu.id
  hvm_boot_firmware = "uefi"
  cloud_config = templatefile("cloud_config.tftpl", {
    hostname = "xorch-lab"
    domain = "morris.lan"
  })
  cloud_network_config = templatefile("cloud_network_config.tftpl", {
    ip = "10.1.55.7"
  })
  wait_for_ip = "true"

  network {
    network_id = data.xenorchestra_network.public.id
  }
  network {
    network_id = data.xenorchestra_network.clusteric.id
  }

  disk {
    sr_id = data.xenorchestra_sr.rootvdi.id
    name_label = "xorch-lab_disk0"
    size = 8589934592
  }
}