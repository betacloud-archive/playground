resource "openstack_compute_instance_v2" "instance" {
  name                    = var.project
  flavor_name             = var.flavor_name
  image_name              = var.image_name
  key_pair                = var.pubkey
  availability_zone_hints = var.zone_hints
  security_groups         = var.secgroups

  network {
    uuid = var.network_id
  }
}
