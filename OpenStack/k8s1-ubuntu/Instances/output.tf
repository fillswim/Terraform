
# # Найти проект по имени
# data "openstack_identity_project_v3" "project" {
#   name = "k8s1-ubuntu"
# }

# # Выводим id проекта
# output "project_id" {
#   value = data.openstack_identity_project_v3.project.id
# }

# # # ================================ Network ================================

# # Находим сеть по имени
# data "openstack_networking_network_v2" "private_network" {
#   tenant_id = data.openstack_identity_project_v3.project.id
#   name      = "private-network"
# }

# # Выводим имя сети
# output "private_network_name" {
#   value = data.openstack_networking_network_v2.private_network.name
# }

# # Выводим id сети
# output "private_network_id" {
#   value = data.openstack_networking_network_v2.private_network.id
# }

# # Выводим подсети сети
# output "private_network_subnets" {
#   value = data.openstack_networking_network_v2.private_network.subnets
# }

# # ================================ Subnet ================================

# # Находим подсеть в сети по id сети
# data "openstack_networking_subnet_v2" "private_subnet" {
#   network_id = data.openstack_networking_network_v2.private_network.id
#   name       = "private-subnet"
# }

# # Выводим имя подсети
# output "private_subnet_name" {
#   value = data.openstack_networking_subnet_v2.private_subnet.name
# }

# # Выводим id подсети
# output "private_subnet_id" {
#   value = data.openstack_networking_subnet_v2.private_subnet.id
# }

# # Выводим cidr подсети
# output "private_subnet_cidr" {
#   value = data.openstack_networking_subnet_v2.private_subnet.cidr
# }

# # ================================ Tenant ================================

# # Выводим имя проекта
# data "openstack_identity_project_v3" "project" {
#   name = "k8s1-ubuntu"
# }

# # Выводим id проекта
# output "project_id" {
#   value = data.openstack_identity_project_v3.project.id
# }
