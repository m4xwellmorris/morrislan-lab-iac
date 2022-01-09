data "template_file" "cloud-init_user_mon-lab" {
  template = file("${path.module}/cloud-init_user.tpl")
  vars = {
    hostname = "mon-lab"
    domain = "morris.lan"
  }
}

data "template_file" "cloud-init_net_mon-lab" {
  template = file("${path.module}/cloud-init_net.tpl")
  vars = {
    ip = "10.1.55.28"
  }
}

resource "xenorchestra_cloud_config" "cloud-init_user_mon-lab" {
  name = "cloud-init_user_mon-lab"
  template = data.template_file.cloud-init_user_mon-lab.rendered
}

resource "xenorchestra_cloud_config" "cloud-init_net_mon-lab" {
  name = "cloud-init_net_mon-lab"
  template = data.template_file.cloud-init_net_mon-lab.rendered
}

resource "xenorchestra_vm" "mon-lab" {
  memory_max = 4294967296
  cpus = 2
  name_label = "mon-lab"
  template = data.xenorchestra_template.ubuntu.id
  hvm_boot_firmware = "uefi"
  cloud_config = xenorchestra_cloud_config.cloud-init_user_mon-lab.template
  cloud_network_config = xenorchestra_cloud_config.cloud-init_net_mon-lab.template
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