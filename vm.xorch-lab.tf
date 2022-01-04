data "template_file" "cloudinit_xorch-lab" {
  template = file("${path.module}/config.cloudinit.tpl")
  vars = {
    name = "xorch-lab"
  }
}

resource "xenorchestra_cloud_config" "cloudinit_xorch-lab" {
  name = "cloudinit_xorch-lab"
  template = data.template_file.cloudinit_xorch-lab.rendered
}

resource "xenorchestra_vm" "xorch-lab" {
  memory_max = 4294967296
  cpus = 4
  name_label = "xorch-lab"
  template = data.xenorchestra_template.ubuntu2004img.id
  hvm_boot_firmware = "uefi"
  cloud_config = xenorchestra_cloud_config.cloudinit_xorch-lab.template
  wait_for_ip = "true"

  network {
    network_id = data.xenorchestra_network.lan.id
  }

  disk {
    sr_id = data.xenorchestra_sr.nosan_rootdrives.id
    name_label = "xorch-lab_disk0"
    size = 8589934592
  }
  cloud_network_config = <<EOF
#cloud-config
version: 1
config:
    - type: physical
      name: eth0
      subnets:
      - type: static
        address: '10.1.50.14'
        netmask: '255.255.255.0'
        gateway: '10.1.50.1'
    - type: nameserver
      address:
      - '10.1.50.1'
      - '10.1.50.22'
      - '1.1.1.1'
      - '1.0.0.1'
      search:
      - 'morris.lan'
EOF
}