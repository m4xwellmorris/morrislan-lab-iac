resource "xenorchestra_vm" "duoap-lab" {
  memory_max = 2147483648
  cpus = 2
  name_label = "duoap-lab"
  template = data.xenorchestra_template.ubuntu.id
  hvm_boot_firmware = "uefi"
  cloud_config = templatefile("cloud_config.tftpl", {
    hostname = "duoap-lab"
    domain = "morris.lan"
  })
  cloud_network_config = templatefile("cloud_network_config.tftpl", {
    ip = "10.1.55.10"
  })
  wait_for_ip = "true"

  network {
    network_id = data.xenorchestra_network.public.id
  }

  disk {
    sr_id = data.xenorchestra_sr.rootvdi.id
    name_label = "duoap-lab_disk0"
    size = 8589934592
  }
}