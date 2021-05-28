module "publickey" {
  source = "../../_tfmodules/hcloud/public_key"
  
  project = var.project
}

module "controlplane" {
  source = "../../_tfmodules/hcloud/basic_vm"

  counter = 3
  project = "${var.project}-control-plane"
  pubkey  = module.publickey.public_key
  flavor  = "cpx11"
}

module "workernode" {
  source = "../../_tfmodules/hcloud/basic_vm"

  counter = 1
  project = "${var.project}-worker-node"
  pubkey  = module.publickey.public_key
  flavor  = "cpx11"
}
