module "publickey" {
  source = "../_tfmodules/openstack/public_key"

  project     = var.project
  pubkey_path = var.pubkey_path
}

module "security_group" {
  source = "../_tfmodules/openstack/security_group"

  project = var.project
}

module "network" {
  source = "../_tfmodules/openstack/network_network"

  project = var.project
}

module "subnet" {
  source = "../_tfmodules/openstack/network_subnet"

  project    = var.project
  network_id = module.network.id
}

module "instance" {
  source = "../_tfmodules/openstack/instance"

  flavor_name    = module.flavor.flavor_name
  image_id       = module.image.image_id
  zone_hints     = var.zone
  project        = var.project
  pubkey         = module.publickey.public_key
  secgroups      = [module.security_group.secgroup]
  network_id     = module.network.id
}

module "router" {
  source = "../_tfmodules/openstack/network_router"

  project             = var.project
  external_network_id = var.external_network_id
}

module "router_interface" {
  source = "../_tfmodules/openstack/network_router_interface"

  router_id = module.router.id
  subnet_id = module.subnet.id
}
