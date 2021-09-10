module "publickey" {
  source = "../../_tfmodules/openstack/public_key"
  
  project = var.project
}

module "secgroup_all" {
  source = "../../_tfmodules/openstack/security_group"

  project = var.project
}

module "controlplane" {
  source = "../../_tfmodules/openstack/basic_vm"

  counter = 3
  project = "${var.project}-control-plane"
  pubkey  = module.publickey.public_key
  secgroups = [module.secgroup_all.secgroup]
  flavor  = "4C-4GB-10GB"
}

module "workernode" {
  source = "../../_tfmodules/openstack/basic_vm"

  counter = 3
  project = "${var.project}-worker-node"
  pubkey  = module.publickey.public_key
  secgroups = [module.secgroup_all.secgroup]
  flavor  = "2C-2GB-10GB"
}
