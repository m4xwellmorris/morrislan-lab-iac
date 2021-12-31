resource "xenorchestra_vm" "tf-test-1" {
  memory_max = 2147483648
  cpus = 2
  name_label = "tf-test-1"
  template = data.xenorchestra_template.default.id
  hvm_boot_firmware = "uefi"
  cloud_config = data.xenorchestra_cloud_config.cloud_config.template
  wait_for_ip = "true"

  network {
    network_id = data.xenorchestra_network.lan.id
  }

  disk {
    sr_id = data.xenorchestra_sr.rootdrives.id
    name_label = "tf-test-1_disk0"
    size = 8516192768
  }
}