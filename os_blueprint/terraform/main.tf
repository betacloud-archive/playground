module "publickey" {
  source = "../../_tfmodules/openstack/public_key"

  project = var.project
}

module "secgroup_ssh" {
  source = "../../_tfmodules/openstack/security_group"

  project = var.project
}

module "blueprint" {
  source = "../../_tfmodules/openstack/basic_vm"

  project   = var.project
  pubkey    = module.publickey.public_key
  secgroups = [module.secgroup_ssh.secgroup]
}
