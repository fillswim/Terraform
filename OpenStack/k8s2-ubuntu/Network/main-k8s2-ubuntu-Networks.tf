
module "k8s2-ubuntu-networks" {

  source = "/home/fill/Terraform-Modules/OpenStack/Networks"
  # source = "github.com/fillswim/Terraform-Modules/OpenStack/Networks"

  # Project
  project-name = "k8s2-ubuntu"

  # Настройки ключа для доступа по SSH
  ssh_keypair_1_name = "keypair-1"
  ssh_public_key_1   = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKKb8Ba0ljYNKK5gJlaOKqwskwlsvZzB/Ka8CWmpGHkL fills@dell"

  # Настройки приватной сети
  private_network_name           = "private-network"
  private_subnet_name            = "private-subnet"
  private_subnet_cidr            = "10.0.12.0/24"
  private_subnet_gateway_ip      = "10.0.12.1"
  private_subnet_dns_nameservers = ["192.168.2.11", "192.168.2.12"]
  private_port_1_name            = "private-port-1"

  # Настройки публичной сети
  public_network_name = "public"
  public_subnet_name  = "public-subnet"

  # Настройки роутера
  router_name                  = "router-1"
  external_fixed_ip_ip_address = "172.16.12.1"
  secgroup_name                = "secgroup-1"
}

output "k8s2-ubuntu-networks-details" {
  description = "Details of the created networks"
  value       = module.k8s2-ubuntu-networks.details
}
