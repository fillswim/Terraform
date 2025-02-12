
# ================================== Network =================================

resource "openstack_networking_network_v2" "private_network" {
  name           = "demo-tf-private-subnet"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "private_subnet_1" {
  network_id      = openstack_networking_network_v2.private_network.id
  cidr            = "10.0.3.0/24"
  dns_nameservers = ["192.168.2.11", "192.168.2.12"]
}

# ================================== Router ==================================

data "openstack_networking_network_v2" "public_network" {
  name = "public"
}

output "public_network_id" {
  value = data.openstack_networking_network_v2.public_network.id
}

resource "openstack_networking_router_v2" "router_1" {
  name                = "router"
  admin_state_up      = true
  external_network_id = data.openstack_networking_network_v2.public_network.id
}

resource "openstack_networking_router_interface_v2" "router_interface_1" {
  router_id = openstack_networking_router_v2.router_1.id
  subnet_id = openstack_networking_subnet_v2.private_subnet_1.id
}

# ============================== Security Group ==============================

resource "openstack_networking_secgroup_v2" "secgroup_1" {
  name        = "secgroup_1"
  description = "My neutron security group"
}

# TCP
resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_1" {
  direction      = "ingress"
  ethertype      = "IPv4"
  protocol       = "tcp"
  port_range_min = 0
  port_range_max = 0
  # port_range_min    = 22
  # port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup_1.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_2" {
  direction      = "egress"
  ethertype      = "IPv4"
  protocol       = "tcp"
  port_range_min = 0
  port_range_max = 0
  # port_range_min    = 22
  # port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup_1.id
}

# UDP
resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_3" {
  direction      = "ingress"
  ethertype      = "IPv4"
  protocol       = "udp"
  port_range_min = 0
  port_range_max = 0
  # port_range_min    = 22
  # port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup_1.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_4" {
  direction      = "egress"
  ethertype      = "IPv4"
  protocol       = "udp"
  port_range_min = 0
  port_range_max = 0
  # port_range_min    = 22
  # port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup_1.id
}

# ICMP
resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_5" {
  direction      = "ingress"
  ethertype      = "IPv4"
  protocol       = "icmp"
  port_range_min = 0
  port_range_max = 0
  # port_range_min    = 22
  # port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup_1.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_6" {
  direction      = "egress"
  ethertype      = "IPv4"
  protocol       = "icmp"
  port_range_min = 0
  port_range_max = 0
  # port_range_min    = 22
  # port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup_1.id
}

# ================================= Instance =================================

# Получить id образа с Ubuntu 24.04
data "openstack_images_image_v2" "ubuntu" {
  name        = "Ubuntu 24.04 LTS [20250122]"
  most_recent = true
}

output "ubuntu-id" {
  value = data.openstack_images_image_v2.ubuntu.id
}

# Получить id типа инстанса "m1.medium"
data "openstack_compute_flavor_v2" "m1_medium" {
  name = "m1.medium"
}

output "m1_medium_id" {
  value = data.openstack_compute_flavor_v2.m1_medium.id
}

# Создать ключевую пару
resource "openstack_compute_keypair_v2" "keypair_1" {
  name       = "keypair-1"
  public_key = var.ssh-public-key-1
}

# Создать инстанс
resource "openstack_compute_instance_v2" "ubuntu_test" {
  name            = "ubuntu-24.04-test-1"
  image_id        = data.openstack_images_image_v2.ubuntu.id
  flavor_id       = data.openstack_compute_flavor_v2.m1_medium.id
  key_pair        = openstack_compute_keypair_v2.keypair_1.id
  security_groups = [openstack_networking_secgroup_v2.secgroup_1.name]
  admin_pass      = "123qweasd"

  network {
    name        = openstack_networking_network_v2.private_network.name
    fixed_ip_v4 = var.instance-ip-v4
  }
}

# =============================== Floating IP ================================

# Получить порт инстанса по его IP
data "openstack_networking_port_v2" "port_1" {
  fixed_ip = var.instance-ip-v4
}

output "port-output" {
  value = data.openstack_networking_port_v2.port_1.id
}

# Создать плавающий IP
resource "openstack_networking_floatingip_v2" "floatip_1" {
  pool    = data.openstack_networking_network_v2.public_network.name
  address = var.floating-ip-v4
}

# Связать плавающий IP c портом инстанса
resource "openstack_networking_floatingip_associate_v2" "fip_associate_1" {
  floating_ip = var.floating-ip-v4
  port_id     = data.openstack_networking_port_v2.port_1.id
}
