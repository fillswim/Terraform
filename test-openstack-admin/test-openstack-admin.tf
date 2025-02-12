
# ================================== Project =================================

resource "openstack_identity_project_v3" "project_demo_tf" {
  name        = "demo-tf"
  description = "A project created by Terraform"
}

resource "openstack_compute_quotaset_v2" "quotaset_demo_tf" {
  project_id           = openstack_identity_project_v3.project_demo_tf.id
  key_pairs            = 10
  ram                  = 40960
  cores                = 32
  instances            = 30
  server_groups        = 4
  server_group_members = 8
}

# =================================== User ===================================

resource "openstack_identity_user_v3" "user_demo_tf" {
  default_project_id = openstack_identity_project_v3.project_demo_tf.id
  name               = "demo-tf"
  description        = "Project user created by Terraform"

  password = "123qweasd"
}


# =================================== Role ===================================

# Получить id роли пользователя "admin"
data "openstack_identity_role_v3" "admin" {
  name = "admin"
}

# Вывести id роли пользователя "admin"
output "admin-role-id" {
  value = data.openstack_identity_role_v3.admin.id
}

# Назначить пользователю роль "admin"
resource "openstack_identity_role_assignment_v3" "user_demo_tf_assignment" {
  user_id    = openstack_identity_user_v3.user_demo_tf.id
  project_id = openstack_identity_project_v3.project_demo_tf.id
  role_id    = data.openstack_identity_role_v3.admin.id
}

# =================================== Image ==================================

resource "openstack_images_image_v2" "ubuntu_2404_20250122" {
  name             = "Ubuntu 24.04 LTS [20250122]"
  image_source_url = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
  container_format = "bare"
  disk_format      = "qcow2"
  visibility       = "shared"
}
