data "xenorchestra_pool" "prod" {
  name_label = "morrislan-prod"
}

data "xenorchestra_template" "ubuntu" {
  name_label = "ubuntu2004img"
}

data "xenorchestra_sr" "nosan_rootdrives" {
  name_label = "nosan_rootdrives"
  pool_id = data.xenorchestra_pool.prod.id
}

data "xenorchestra_network" "lan" {
  name_label = "LAN"
  pool_id = data.xenorchestra_pool.prod.id
}