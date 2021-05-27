module "publickey" {
  source = "../../_tfmodules/hcloud/public_key"
  
  project = var.project
}

module "controlplane" {
  source = "../../_tfmodules/hcloud/basic_vm"

  counter = 3
  project = var.project
  pubkey  = module.publickey.public_key
  flavor  = "cpx11"
}
