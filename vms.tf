data "xenorchestra_pool" "prod" {
  name_label = "morrislan-prod"
}

data "xenorchestra_template" "default" {
  name_label = "ubuntu2004img"
}

data "xenorchestra_sr" "rootdrives" {
  name_label = "nosan-rootdrives"
  pool_id = data.xenorchestra_pool.prod.id
}

data "xenorchestra_network" "lan" {
  name_label = "LAN"
  pool_id = data.xenorchestra_pool.prod.id
}

data "xenorchestra_cloud_config" "cloud_config" {
  name = "Default-UserConfig"
}