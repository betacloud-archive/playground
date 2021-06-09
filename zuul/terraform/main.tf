module "publickey" {
  source = "../../_tfmodules/otc/public_key"

  project = var.project
}

module "secgroup_zuul" {
  source = "../../_tfmodules/otc/security_group"

  project   = "${var.project}"
  from_port = 1
  to_port   = 65535
}

module "zuul" {
  source = "../../_tfmodules/otc/basic_vm"

  project   = "${var.project}"
  pubkey    = module.publickey.public_key
  secgroups = [module.secgroup_zuul.secgroup]
  flavor    = "s3.xlarge.2" # 4C-8GB
  image     = "Standard_Ubuntu_20.04_latest"
  vip_pool  = "admin_external_net"
  network   = "f63b901a-f6bf-44eb-946e-87458a95feb8"
  disk_size = 20
}
