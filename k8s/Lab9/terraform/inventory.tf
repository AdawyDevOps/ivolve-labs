resource "local_file" "ansible_inventory" {
  filename        = "${path.module}/../ansible/inventory.ini"
  file_permission = "0640"

  content = templatefile("${path.module}/templates/inventory.tpl", {
    master_public_ips  = aws_instance.master[*].public_ip
    master_private_ips = aws_instance.master[*].private_ip
    worker_public_ips  = aws_instance.worker[*].public_ip
    worker_private_ips = aws_instance.worker[*].private_ip
    private_key_path   = pathexpand(var.private_key_path)
    api_endpoint       = aws_lb.api.dns_name
  })
}
