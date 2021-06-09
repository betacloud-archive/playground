resource "openstack_networking_router_v2" "router" {
  name                    = var.project
  admin_state_up          = true
  external_network_id     = var.external_network_id
  availability_zone_hints = var.zone_hints
}
