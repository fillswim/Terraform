
module "k8s1-ubuntu-workers" {

  source = "/home/fill/Terraform-Modules/OpenStack/Instance"
  # source = "github.com/fillswim/Terraform-Modules/OpenStack/Instance"

  # Project
  project-name = "k8s1-ubuntu"

  # Count of instances
  instance-count       = 2
  starting-host-number = 14 # Стартовый номер хоста (для расчета IP адреса)

  # Instance
  instance-name-prefix = "k8s1-ubuntu-worker"
  admin-password       = "123qweasd"

  # Flavor
  flavor-name = "m1.medium"

  # Image
  image-name = "Ubuntu 24.04 LTS"

  # Instance IP address
  private-network-name = "private-network"
  private-subnet-name  = "private-subnet"

  # Floating IP address
  create-floating-ip = false
  # public-network-name = "public"
  # floating-ip-v4      = "172.16.11.10"

  # Keypair
  keypair-name = "keypair-1"

  # Networks
  secgroup-name = "secgroup-1"
}

output "k8s1-ubuntu-workers" {
  description = "Details of the created instances"
  value = module.k8s1-ubuntu-workers.details
}
