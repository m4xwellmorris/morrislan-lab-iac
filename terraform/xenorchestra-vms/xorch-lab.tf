data "template_file" "cloud-init_user_xorch-lab" {
  template = file("${path.module}/cloud-init_user.tpl")
  vars = {
    hostname = "xorch-lab"
    domain = "morris.lan"
  }
}

data "template_file" "cloud-init_net_xorch-lab" {
  template = file("${path.module}/cloud-init_net.tpl")
  vars = {
    ip = "10.1.55.7"
  }
}

resource "xenorchestra_cloud_config" "cloud-init_user_xorch-lab" {
  name = "cloud-init_user_xorch-lab"
  template = data.template_file.cloud-init_user_xorch-lab.rendered
}

resource "xenorchestra_cloud_config" "cloud-init_net_xorch-lab" {
  name = "cloud-init_net_xorch-lab"
  template = data.template_file.cloud-init_net_xorch-lab.rendered
}

resource "xenorchestra_vm" "xorch-lab" {
  memory_max = 4294967296
  cpus = 2
  name_label = "xorch-lab"
  template = data.xenorchestra_template.ubuntu.id
  hvm_boot_firmware = "uefi"
  cloud_config = xenorchestra_cloud_config.cloud-init_user_xorch-lab.template
  cloud_network_config = xenorchestra_cloud_config.cloud-init_net_xorch-lab.template
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