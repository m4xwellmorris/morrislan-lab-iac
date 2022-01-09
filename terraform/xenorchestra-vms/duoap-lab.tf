data "template_file" "cloud-init_user_duoap-lab" {
  template = file("${path.module}/cloud-init_user.tpl")
  vars = {
    hostname = "duoap-lab"
    domain = "morris.lan"
  }
}

data "template_file" "cloud-init_net_duoap-lab" {
  template = file("${path.module}/cloud-init_net.tpl")
  vars = {
    ip = "10.1.55.10"
  }
}

resource "xenorchestra_cloud_config" "cloud-init_user_duoap-lab" {
  name = "cloud-init_user_duoap-lab"
  template = data.template_file.cloud-init_user_duoap-lab.rendered
}

resource "xenorchestra_cloud_config" "cloud-init_net_duoap-lab" {
  name = "cloud-init_net_duoap-lab"
  template = data.template_file.cloud-init_net_duoap-lab.rendered
}

resource "xenorchestra_vm" "duoap-lab" {
  memory_max = 2147483648
  cpus = 2
  name_label = "duoap-lab"
  template = data.xenorchestra_template.ubuntu.id
  hvm_boot_firmware = "uefi"
  cloud_config = xenorchestra_cloud_config.cloud-init_user_duoap-lab.template
  cloud_network_config = xenorchestra_cloud_config.cloud-init_net_duoap-lab.template
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