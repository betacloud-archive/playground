output "secgroup" {
  value = openstack_compute_secgroup_v2.secgroup.name
}

output "id" {
  value = openstack_compute_secgroup_v2.secgroup.id
}
