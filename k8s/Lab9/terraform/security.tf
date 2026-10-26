data "http" "my_ip" {
  url = "https://checkip.amazonaws.com"
}

locals {
  ssh_cidr = var.ssh_allowed_cidr != "" ? var.ssh_allowed_cidr : "${chomp(data.http.my_ip.response_body)}/32"
}

resource "aws_security_group" "nodes" {
  name        = "${var.project_name}-nodes"
  description = "Kubernetes nodes (masters and workers)"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-nodes-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "self_all" {
  security_group_id            = aws_security_group.nodes.id
  description                  = "All traffic between cluster nodes"
  referenced_security_group_id = aws_security_group.nodes.id
  ip_protocol                  = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.nodes.id
  description       = "SSH from my IP only"
  cidr_ipv4         = local.ssh_cidr
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "api_from_vpc" {
  security_group_id = aws_security_group.nodes.id
  description       = "Kubernetes API from inside the VPC (internal NLB)"
  cidr_ipv4         = var.vpc_cidr
  ip_protocol       = "tcp"
  from_port         = 6443
  to_port           = 6443
}

resource "aws_vpc_security_group_egress_rule" "all_out" {
  security_group_id = aws_security_group.nodes.id
  description       = "Allow all outbound"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
