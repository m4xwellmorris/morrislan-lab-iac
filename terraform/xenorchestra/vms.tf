data "xenorchestra_pool" "pool" {
  name_label = "morrislan-lab"
}

data "xenorchestra_template" "ubuntu" {
  name_label = "ubuntu2004img-lab"
}

data "xenorchestra_sr" "rootvdi" {
  name_label = "rootvdi"
  pool_id = data.xenorchestra_pool.pool.id
}

data "xenorchestra_sr" "datavdi" {
  name_label = "datavdi"
  pool_id = data.xenorchestra_pool.pool.id
}

data "xenorchestra_network" "public" {
  name_label = "LAN"
  pool_id = data.xenorchestra_pool.pool.id
}

data "xenorchestra_network" "clusteric" {
  name_label = "Cluster IC"
  pool_id = data.xenorchestra_pool.pool.id
}

resource "xenorchestra_vm" "bw-lab" {
  memory_max = 4294967296
  cpus = 4
  name_label = "bw-lab"
  template = data.xenorchestra_template.ubuntu.id
  hvm_boot_firmware = "uefi"
  cloud_config = templatefile("cloud_config.tftpl", {
    hostname = "bw-lab"
    domain = "morris.lan"
  })
  cloud_network_config = templatefile("cloud_network_config.tftpl", {
    ip = "10.1.55.37"
  })
  wait_for_ip = "true"

  network {
    network_id = data.xenorchestra_network.public.id
  }

  disk {
    sr_id = data.xenorchestra_sr.rootvdi.id
    name_label = "bw-lab_disk0"
    size = 8589934592
  }
  disk {
    sr_id = data.xenorchestra_sr.datavdi.id
    name_label = "bw-lab_disk1"
    size = 10737418240
  }
}

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

resource "xenorchestra_vm" "mon-lab" {
  memory_max = 4294967296
  cpus = 2
  name_label = "mon-lab"
  template = data.xenorchestra_template.ubuntu.id
  hvm_boot_firmware = "uefi"
  cloud_config = templatefile("cloud_config.tftpl", {
    hostname = "mon-lab"
    domain = "morris.lan"
  })
  cloud_network_config = templatefile("cloud_network_config.tftpl", {
    ip = "10.1.55.28"
  })
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

resource "xenorchestra_vm" "ops-lab" {
  memory_max = 4294967296
  cpus = 4
  name_label = "ops-lab"
  template = data.xenorchestra_template.ubuntu.id
  hvm_boot_firmware = "uefi"
  cloud_config = templatefile("cloud_config.tftpl", {
    hostname = "ops-lab"
    domain = "morris.lan"
  })
  cloud_network_config = templatefile("cloud_network_config.tftpl", {
    ip = "10.1.55.4"
  })
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

resource "xenorchestra_vm" "unc-lab" {
  memory_max = 3221225472
  cpus = 2
  name_label = "unc-lab"
  template = data.xenorchestra_template.ubuntu.id
  hvm_boot_firmware = "uefi"
  cloud_config = templatefile("cloud_config.tftpl", {
    hostname = "unc-lab"
    domain = "morris.lan"
  })
  cloud_network_config = templatefile("cloud_network_config.tftpl", {
    ip = "10.1.55.34"
  })
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

resource "xenorchestra_vm" "xorch-lab" {
  memory_max = 4294967296
  cpus = 2
  name_label = "xorch-lab"
  template = data.xenorchestra_template.ubuntu.id
  hvm_boot_firmware = "uefi"
  cloud_config = templatefile("cloud_config.tftpl", {
    hostname = "xorch-lab"
    domain = "morris.lan"
  })
  cloud_network_config = templatefile("cloud_network_config.tftpl", {
    ip = "10.1.55.7"
  })
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