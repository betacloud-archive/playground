module "publickey" {
  source = "./_tfmodules/otc/public_key"

  project = var.project
}

module "secgroup_zuul_ssh" {
  source = "./_tfmodules/otc/security_group"

  project   = "${var.project}-ssh"
  from_port = 22
  to_port   = 22
}

module "secgroup_zuul_web" {
  source = "./_tfmodules/otc/security_group"

  project   = "${var.project}-web"
  from_port = 9000
  to_port   = 9000
}

module "secgroup_zuul_log" {
  source = "./_tfmodules/otc/security_group"

  project   = "${var.project}-log"
  from_port = 8000
  to_port   = 8000
}

module "zuul" {
  source = "./_tfmodules/otc/basic_vm"

  project   = "${var.project}-controller"
  pubkey    = module.publickey.public_key
  secgroups = [
    module.secgroup_zuul_ssh.secgroup,
    module.secgroup_zuul_web.secgroup,
    module.secgroup_zuul_log.secgroup
  ]
  flavor    = "s3.xlarge.2"  # 4C-8GB
  image     = "Standard_Ubuntu_20.04_latest"
  vip_pool  = "admin_external_net"
  network   = "f63b901a-f6bf-44eb-946e-87458a95feb8"
  disk_size = 20
}
