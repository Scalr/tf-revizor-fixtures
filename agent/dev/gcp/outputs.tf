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


output "package_bucket_path" {
  value = replace(replace(data.local_file.url.content, "gs://${var.gcp_bucket}/", ""), "\n", "")
}


output "package_signed_url" {
  value = replace(data.google_storage_object_signed_url.package.signed_url, "\n", "")
}

output "id" {
  value = resource.random_id.id.hex
}
