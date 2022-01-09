resource "xenorchestra_vm" "hass-lab" {
  memory_max = 4294967296
  cpus = 4
  name_label = "hass-lab"
  template = data.xenorchestra_template.ubuntu.id
  hvm_boot_firmware = "uefi"
  wait_for_ip = "false"

  network {
    network_id = data.xenorchestra_network.public.id
  }

  disk {
    sr_id = data.xenorchestra_sr.rootvdi.id
    name_label = "hass-lab_disk0"
    size = 16106127360
  }
}