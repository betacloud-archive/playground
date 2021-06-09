resource "openstack_networking_network_v2" "network" {
  name                    = var.project
  admin_state_up          = "true"
  availability_zone_hints = var.zone_hints
}
