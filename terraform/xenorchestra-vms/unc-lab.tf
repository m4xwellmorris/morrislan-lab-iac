resource "xenorchestra_vm" "unc-lab" {
  memory_max = 3221225472
  cpus = 2
  name_label = "unc-lab"
  template = data.xenorchestra_template.ubuntu.id
  hvm_boot_firmware = "uefi"
  cloud_config = templatefile("cloud_config.tftpl", {
    hostname = "unc-lab"
    domain = "morris.lan"
  })
  cloud_network_config = templatefile("cloud_network_config.tftpl", {
    ip = "10.1.55.34"
  })
  wait_for_ip = "true"

  network {
    network_id = data.xenorchestra_network.public.id
  }

  disk {
    sr_id = data.xenorchestra_sr.rootvdi.id
    name_label = "unc-lab_disk0"
    size = 8589934592
  }
}