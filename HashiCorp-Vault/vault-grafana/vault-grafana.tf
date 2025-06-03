# # ================================= S3 Backend =================================
# terraform {
#   backend "s3" {
#     bucket = "terraform-state"
#     key    = "vault-grafana/terraform.tfstate" # ! Необхожимо изменить для каждой папки !

#     # endpoints = {
#     #   s3 = "http://api.minio.fillswim.local"
#     # }

#     region = "main"

#     # access_key = "admin-username"
#     # secret_key = "admin-password"

#     skip_credentials_validation = true
#     skip_metadata_api_check     = true
#     skip_region_validation      = true
#     skip_requesting_account_id  = true
#     use_path_style              = true

#   }
# }


# ================================ Remote State ================================

# Состояние HashiCorp Valt проекта
data "terraform_remote_state" "remote_state" {
  backend = "s3"
  config = {
    bucket                      = var.remote_state_bucket_name
    key                         = var.remote_state_bucket_key
    region                      = var.remote_state_region
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    use_path_style              = true
  }
}

# Вывод всего из Remote State Vault (для отладки)
output "remote_state_outputs" {
  value = data.terraform_remote_state.remote_state.outputs
}

# # =================================== Vault ====================================

# # (Опционально) Получить данные о пути включенной аутентификации
# data "vault_auth_backend" "kubernetes" {
#   # path = "kubernetes"
#   path = data.terraform_remote_state.remote_state.outputs.vault_auth_backend_kubernetes_path
# }

# output "data_vault_auth_backend_kubernetes" {
#   value = data.vault_auth_backend.kubernetes
# }

# # ================================== Policies ==================================

# Добавить полилитику
resource "vault_policy" "policy" {
  name   = var.vault_policy_name
  policy = file(var.vault_policy_file)
}

# output "vault_policy_output" {
#   value = vault_policy.policy
# }

# # # ================================== Folders ===================================

# Включить механизм KV2 для папки "grafana"
resource "vault_mount" "folder" {
  path        = var.vault_mount_path
  type        = var.vault_mount_type
  description = var.vault_mount_description
}

# output "vault_mount_folder_output" {
#   value = vault_mount.folder
# }

# # # ==================================== Roles ===================================

# Создание роли для доступа к секрету 
resource "vault_kubernetes_auth_backend_role" "role" {
  # backend                          = data.terraform_remote_state.remote_state.outputs.vault_auth_backend_kubernetes_path
  backend                          = var.vault_role_backend
  role_name                        = var.vault_role_name
  bound_service_account_names      = var.vault_role_bound_service_account_names
  bound_service_account_namespaces = var.vault_role_bound_service_account_namespaces
  token_ttl                        = 86400 # 24 часа 
  token_policies                   = ["default", vault_policy.policy.name]
  audience                         = "vault"
}

# output "role" {
#   value = vault_kubernetes_auth_backend_role.role
# }

output "role_backend" {
  value = vault_kubernetes_auth_backend_role.role.backend
}

output "role_name" {
  value = vault_kubernetes_auth_backend_role.role.role_name
}

output "role_bound_service_account_names" {
  value = vault_kubernetes_auth_backend_role.role.bound_service_account_names
}

output "role_bound_service_account_namespaces" {
  value = vault_kubernetes_auth_backend_role.role.bound_service_account_namespaces
}

# # =================================== Secret ===================================

# Создать секрет
resource "vault_generic_secret" "secret" {
  path      = "${vault_mount.folder.path}/${var.vault_secret_name}"
  data_json = file(var.vault_secret_file)
}

