data "template_file" "cloud-init_user_bw-lab" {
  template = file("${path.module}/cloud-init_user.tpl")
  vars = {
    hostname = "bw-lab"
    domain = "morris.lan"
  }
}

data "template_file" "cloud-init_net_bw-lab" {
  template = file("${path.module}/cloud-init_net.tpl")
  vars = {
    ip = "10.1.55.37"
  }
}

resource "xenorchestra_cloud_config" "cloud-init_user_bw-lab" {
  name = "cloud-init_user_bw-lab"
  template = data.template_file.cloud-init_user_bw-lab.rendered
}

resource "xenorchestra_cloud_config" "cloud-init_net_bw-lab" {
  name = "cloud-init_net_bw-lab"
  template = data.template_file.cloud-init_net_bw-lab.rendered
}

resource "xenorchestra_vm" "bw-lab" {
  memory_max = 17179869184
  cpus = 8
  name_label = "bw-lab"
  template = data.xenorchestra_template.ubuntu.id
  hvm_boot_firmware = "uefi"
  cloud_config = xenorchestra_cloud_config.cloud-init_user_bw-lab.template
  cloud_network_config = xenorchestra_cloud_config.cloud-init_net_bw-lab.template
  wait_for_ip = "true"
  exp_nested_hvm = "true"

  network {
    network_id = data.xenorchestra_network.lan.id
  }

  disk {
    sr_id = data.xenorchestra_sr.rootdrives.id
    name_label = "bw-lab_disk0"
    size = 26843545600
  }
  disk {
    sr_id = data.xenorchestra_sr.rootdrives.id
    name_label = "bw-lab_disk1"
    size = 10737418240
  }
}