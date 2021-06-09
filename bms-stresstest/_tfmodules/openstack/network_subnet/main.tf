resource "openstack_networking_subnet_v2" "subnet" {
  name       = var.project
  network_id = var.network_id
  cidr       = "192.168.100.0/24"
  ip_version = 4
}
