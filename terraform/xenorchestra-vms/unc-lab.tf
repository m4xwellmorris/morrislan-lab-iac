data "template_file" "cloud-init_user_unc-lab" {
  template = file("${path.module}/cloud-init_user.tpl")
  vars = {
    hostname = "unc-lab"
    domain = "morris.lan"
  }
}

data "template_file" "cloud-init_net_unc-lab" {
  template = file("${path.module}/cloud-init_net.tpl")
  vars = {
    ip = "10.1.55.34"
  }
}

resource "xenorchestra_cloud_config" "cloud-init_user_unc-lab" {
  name = "cloud-init_user_unc-lab"
  template = data.template_file.cloud-init_user_unc-lab.rendered
}

resource "xenorchestra_cloud_config" "cloud-init_net_unc-lab" {
  name = "cloud-init_net_unc-lab"
  template = data.template_file.cloud-init_net_unc-lab.rendered
}

resource "xenorchestra_vm" "unc-lab" {
  memory_max = 3221225472
  cpus = 2
  name_label = "unc-lab"
  template = data.xenorchestra_template.ubuntu.id
  hvm_boot_firmware = "uefi"
  cloud_config = xenorchestra_cloud_config.cloud-init_user_unc-lab.template
  cloud_network_config = xenorchestra_cloud_config.cloud-init_net_unc-lab.template
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