data "template_file" "cloud-init_user_ops-lab" {
  template = file("${path.module}/cloud-init_user.tpl")
  vars = {
    hostname = "ops-lab"
    domain = "morris.lan"
  }
}

data "template_file" "cloud-init_net_ops-lab" {
  template = file("${path.module}/cloud-init_net.tpl")
  vars = {
    ip = "10.1.55.4"
  }
}

resource "xenorchestra_cloud_config" "cloud-init_user_ops-lab" {
  name = "cloud-init_user_ops-lab"
  template = data.template_file.cloud-init_user_ops-lab.rendered
}

resource "xenorchestra_cloud_config" "cloud-init_net_ops-lab" {
  name = "cloud-init_net_ops-lab"
  template = data.template_file.cloud-init_net_ops-lab.rendered
}

resource "xenorchestra_vm" "ops-lab" {
  memory_max = 4294967296
  cpus = 4
  name_label = "ops-lab"
  template = data.xenorchestra_template.ubuntu.id
  hvm_boot_firmware = "uefi"
  cloud_config = xenorchestra_cloud_config.cloud-init_user_ops-lab.template
  cloud_network_config = xenorchestra_cloud_config.cloud-init_net_ops-lab.template
  wait_for_ip = "true"

  network {
    network_id = data.xenorchestra_network.public.id
  }

  disk {
    sr_id = data.xenorchestra_sr.rootvdi.id
    name_label = "ops-lab_disk0"
    size = 8589934592
  }
}