output "floating_ips" {
  value = hcloud_server.instance.*.ipv4_address
}
