module "publickey" {
  source = "../../_tfmodules/otc/public_key"

  project = var.project
}

module "secgroup_ssh" {
  source = "../../_tfmodules/otc/security_group"

  project   = "${var.project}-ssh"
  from_port = 22
  to_port   = 22
}

module "secgroup_vault" {
  source = "../../_tfmodules/otc/security_group"

  project   = "${var.project}-vault"
  from_port = 8200
  to_port   = 8203
}

module "unsealer" {
  source = "../../_tfmodules/otc/basic_vm"

  project   = "${var.project}-unsealer"
  pubkey    = module.publickey.public_key
  secgroups = [module.secgroup_ssh.secgroup, module.secgroup_vault.secgroup]
  flavor    = "s3.large.1" # 2C-2GB
  image     = "Standard_Ubuntu_20.04_latest"
  vip_pool  = "admin_external_net"
  network   = "f63b901a-f6bf-44eb-946e-87458a95feb8"
}

module "cluster" {
  source = "../../_tfmodules/otc/basic_vm"

  counter   = 3
  project   = "${var.project}-cluster-node"
  pubkey    = module.publickey.public_key
  secgroups = [module.secgroup_ssh.secgroup, module.secgroup_vault.secgroup]
  flavor    = "s3.large.1" # 2C-2GB
  image     = "Standard_Ubuntu_20.04_latest"
  vip_pool  = "admin_external_net"
  network   = "f63b901a-f6bf-44eb-946e-87458a95feb8"
}
