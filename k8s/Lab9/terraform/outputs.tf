output "api_endpoint" {
  description = "Internal NLB DNS name used as the Kubernetes API endpoint"
  value       = aws_lb.api.dns_name
}

output "master_public_ips" {
  value = aws_instance.master[*].public_ip
}

output "worker_public_ips" {
  value = aws_instance.worker[*].public_ip
}

output "ssh_master_1" {
  value = "ssh -i ${var.private_key_path} ubuntu@${aws_instance.master[0].public_ip}"
}

output "kubectl_tunnel" {
  description = "Run this in a separate terminal to reach the API server from WSL"
  value       = "ssh -i ${var.private_key_path} -N -L 6443:${aws_lb.api.dns_name}:6443 ubuntu@${aws_instance.master[0].public_ip}"
}

output "ssh_allowed_cidr" {
  value = local.ssh_cidr
}
