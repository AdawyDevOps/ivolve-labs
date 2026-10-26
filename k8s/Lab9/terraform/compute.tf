data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_key_pair" "this" {
  key_name   = "${var.project_name}-key"
  public_key = file(pathexpand(var.public_key_path))
}

resource "aws_instance" "master" {
  count                  = 3
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.master_instance_type
  subnet_id              = aws_subnet.public[count.index].id
  vpc_security_group_ids = [aws_security_group.nodes.id]
  key_name               = aws_key_pair.this.key_name

  root_block_device {
    volume_size = var.root_volume_gb
    volume_type = "gp3"
  }

  metadata_options {
    http_tokens = "required"
  }

  tags = {
    Name = "${var.project_name}-master-${count.index + 1}"
    Role = "control-plane"
  }
}

resource "aws_instance" "worker" {
  count                  = var.worker_count
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.worker_instance_type
  subnet_id              = aws_subnet.public[count.index % 3].id
  vpc_security_group_ids = [aws_security_group.nodes.id]
  key_name               = aws_key_pair.this.key_name

  root_block_device {
    volume_size = var.root_volume_gb
    volume_type = "gp3"
  }

  metadata_options {
    http_tokens = "required"
  }

  tags = {
    Name = "${var.project_name}-worker-${count.index + 1}"
    Role = "worker"
  }
}
