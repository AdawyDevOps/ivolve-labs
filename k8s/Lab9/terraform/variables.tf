variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-north-1"
}

variable "project_name" {
  description = "Prefix used in the names of all resources"
  type        = string
  default     = "kubeforge"
}

variable "vpc_cidr" {
  description = "CIDR block of the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "master_instance_type" {
  description = "Instance type for the 3 control plane nodes (kubeadm needs at least 2 vCPU and about 2 GB RAM)"
  type        = string
  default     = "t3.small"
}

variable "worker_instance_type" {
  description = "Instance type for the worker nodes"
  type        = string
  default     = "t3.small"
}

variable "worker_count" {
  description = "Number of worker nodes"
  type        = number
  default     = 2
}

variable "root_volume_gb" {
  description = "Root disk size per node in GB"
  type        = number
  default     = 20
}

variable "public_key_path" {
  description = "Path to the SSH public key that will be uploaded to AWS (inside WSL)"
  type        = string
  default     = "~/.ssh/kubeforge.pub"
}

variable "private_key_path" {
  description = "Path to the matching SSH private key (used by Ansible)"
  type        = string
  default     = "~/.ssh/kubeforge"
}

variable "ssh_allowed_cidr" {
  description = "CIDR allowed to SSH to the nodes. Leave empty to auto-detect your current public IP."
  type        = string
  default     = ""
}
