output "cluster_ips" {
  value = module.cluster.floating_ips
}

output "unsealer_ips" {
  value = module.unsealer.floating_ips
}
