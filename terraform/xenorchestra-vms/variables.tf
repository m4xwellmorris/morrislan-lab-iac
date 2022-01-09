data "xenorchestra_pool" "pool" {
  name_label = "morrislan-lab"
}

data "xenorchestra_template" "ubuntu" {
  name_label = "ubuntu2004img"
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