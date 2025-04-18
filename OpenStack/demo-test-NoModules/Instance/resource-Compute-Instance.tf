
# Создать инстанс
resource "openstack_compute_instance_v2" "instance" {
  name            = var.instance-name
  image_id        = data.openstack_images_image_v2.image.id
  flavor_id       = data.openstack_compute_flavor_v2.m1_medium.id
  key_pair        = data.openstack_compute_keypair_v2.keypair_1.id
  security_groups = [data.openstack_networking_secgroup_v2.secgroup.name]
  admin_pass      = var.admin-password

  network {
    name        = data.openstack_networking_network_v2.private_network.name
    fixed_ip_v4 = var.instance-ip-v4
  }
}