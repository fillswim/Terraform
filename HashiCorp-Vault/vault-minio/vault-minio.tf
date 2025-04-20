# ================================= S3 Backend =================================
terraform {
  backend "s3" {
    bucket = "terraform-state"
    key    = "vault-minio/terraform.tfstate" # ! Необходимо изменить для каждой папки !

    # endpoints = {
    #   s3 = "http://api.minio.fillswim.local"
    # }

    region = "main"

    # access_key = "admin-username"
    # secret_key = "admin-password"

    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    use_path_style              = true

  }
}


# ================================ Remote State ================================

# Состояние из Развертывания конфигурации хранилища HashiCorp Valt "vault_config_k8s1_rhel"
data "terraform_remote_state" "vault_config_k8s1_rhel" {
  backend = "s3"
  config = {
    bucket                      = "terraform-state"
    key                         = "vault-config-k8s1-rhel/terraform.tfstate"
    region                      = "main"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    use_path_style              = true
  }
}

# Вывод всего из Remote State
output "data_terraform_remote_state_vault_config_k8s1_rhel" {
  # value = data.terraform_remote_state.vault_config_k8s1_rhel.outputs
  value = data.terraform_remote_state.vault_config_k8s1_rhel.outputs.vault_auth_backend_kubernetes_path
}

# =================================== Vault ====================================

# (Опционально) Получить данные о пути включенной аутентификации
data "vault_auth_backend" "kubernetes" {
  path = "kubernetes"
}

# output "data_vault_auth_backend_kubernetes" {
#   value = data.vault_auth_backend.kubernetes
# }

# ================================== Policies ==================================

# Добавить полилитику для разработчиков
resource "vault_policy" "minio_secret_policy" {
  name   = "minio-secret-policy"
  policy = file("policies/minio-secret-policy.hcl")
}

# ================================== Folders ===================================

# Включить механизм KV2 для папки "minio"
resource "vault_mount" "minio" {
  path        = "minio"
  type        = "kv-v2"
  description = "KV2 Secrets Engine for MinIO"
}

# ==================================== Roles ===================================

# Создание роли для доступа к секрету MinIO 
resource "vault_kubernetes_auth_backend_role" "minio_secret_role" {
  # Из data vault_auth_backend.kubernetes
  # backend                          = data.vault_auth_backend.kubernetes.path
  # Из Remote State
  backend                          = data.terraform_remote_state.vault_config_k8s1_rhel.outputs.vault_auth_backend_kubernetes_path
  role_name                        = "minio-secret-role"
  bound_service_account_names      = ["default"]
  bound_service_account_namespaces = ["minio", "loki"]
  token_ttl                        = 86400 # 24 часа 
  token_policies                   = ["default", vault_policy.minio_secret_policy.name]
  audience                         = "vault"
}

# =================================== Secret ===================================

# Создать секрет для MinIO
resource "vault_generic_secret" "minio_secret" {
  path      = "${vault_mount.minio.path}/minio-secret"
  data_json = file(".secrets/minio-secret.json")
}
