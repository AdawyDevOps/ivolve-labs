[masters]
%{ for i, ip in master_public_ips ~}
master-${i + 1} ansible_host=${ip} private_ip=${master_private_ips[i]}
%{ endfor ~}

[workers]
%{ for i, ip in worker_public_ips ~}
worker-${i + 1} ansible_host=${ip} private_ip=${worker_private_ips[i]}
%{ endfor ~}

[all:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=${private_key_path}
api_endpoint=${api_endpoint}
