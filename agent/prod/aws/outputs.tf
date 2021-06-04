output "instance-ssh" {
  value = tomap({
    for k, inst in aws_instance.scalr_agent: inst.tags["Name"] => "ssh ${var.ssh_user}@${inst.public_ip}"
  })
}

output "public_ips" {
  value = tomap({
    for k, inst in aws_instance.scalr_agent: inst.tags["Name"] => inst.public_ip
  })
}
