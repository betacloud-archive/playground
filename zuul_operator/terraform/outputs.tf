output "control_planes" {
  value = module.controlplane.floating_ips
}

output "worker_nodes" {
  value = module.workernode.floating_ips
}
