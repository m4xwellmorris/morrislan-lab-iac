resource "xenorchestra_vm" "mon-lab" {
  memory_max = 4294967296
  cpus = 2
  name_label = "mon-lab"
  template = data.xenorchestra_template.ubuntu.id
  hvm_boot_firmware = "uefi"
  cloud_config = templatefile("cloud_config.tftpl", {
    hostname = "mon-lab"
    domain = "morris.lan"
  })
  cloud_network_config = templatefile("cloud_network_config.tftpl", {
    ip = "10.1.55.28"
  })
  wait_for_ip = "true"

  network {
    network_id = data.xenorchestra_network.public.id
  }

  disk {
    sr_id = data.xenorchestra_sr.rootvdi.id
    name_label = "mon-lab_disk0"
    size = 8589934592
  }
  disk {
    sr_id = data.xenorchestra_sr.datavdi.id
    name_label = "mon-lab_disk1"
    size = 8589934592
  }
}