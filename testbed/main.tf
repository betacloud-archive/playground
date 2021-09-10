locals {
  timestamp = formatdate("YYYY-MM-DD", timestamp())
}

data "local_file" "pubkey" {
  filename = pathexpand("~/.ssh/id_rsa.pub")
}

resource "openstack_compute_keypair_v2" "keypair" {
  name       = local.timestamp
  public_key = data.local_file.pubkey.content
}

module "instance" {
  source = "./instance"
  count  = 1
  
  name   = "instance_${count.index}__${local.timestamp}"
  pubkey = openstack_compute_keypair_v2.keypair.name
}

