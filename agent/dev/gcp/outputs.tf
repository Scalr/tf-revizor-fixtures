output "instance_ssh" {
  value = tomap({
    for k, addr in resource.google_compute_address.static : "agent-${k}" => "ssh ${var.ssh_user}@${addr.address}"
  })
}

output "public_ips" {
  value = tomap({
    for k, addr in resource.google_compute_address.static : "agent-${k}" => addr.address
  })
}

output "branch" {
  value = var.branch
}
