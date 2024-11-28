# ================================= S3 Backend =================================
terraform {
  backend "s3" {
    bucket = "terraform-state"
    key    = "vault-grafana/terraform.tfstate" # ! Необхожимо изменить для каждой папки !

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

# Состояние из Развертывания конфигурации хранилища HashiCorp Valt "vault-config-k8s1-rhel"
data "terraform_remote_state" "vault-config-k8s1-rhel" {
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
output "data_terraform_remote_state_vault-config-k8s1-rhel" {
  # value = data.terraform_remote_state.vault-config-k8s1-rhel.outputs
  value = data.terraform_remote_state.vault-config-k8s1-rhel.outputs.vault_auth_backend_kubernetes_path
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
resource "vault_policy" "grafana_ui_secret_policy" {
  name   = "grafana-ui-secret-policy"
  policy = file("policies/grafana-ui-secret-policy.hcl")
}

# ================================== Folders ===================================

# Включить механизм KV2 для папки "grafana"
resource "vault_mount" "grafana" {
  path        = "grafana"
  type        = "kv-v2"
  description = "KV2 Secrets Engine for Grafana"
}

# ==================================== Roles ===================================

# Создание роли для доступа к секрету Grafana 
resource "vault_kubernetes_auth_backend_role" "grafana_ui_secret_role" {
  # Из data vault_auth_backend.kubernetes
  # backend                          = data.vault_auth_backend.kubernetes.path
  # Из Remote State
  backend                          = data.terraform_remote_state.vault-config-k8s1-rhel.outputs.vault_auth_backend_kubernetes_path
  role_name                        = "grafana-ui-secret-role"
  bound_service_account_names      = ["default"]
  bound_service_account_namespaces = ["grafana"]
  token_ttl                        = 86400 # 24 часа 
  token_policies                   = ["default", vault_policy.grafana_ui_secret_policy.name]
  audience                         = "vault"
}

# =================================== Secret ===================================

# Создать секрет для Grafana UI
resource "vault_generic_secret" "grafana_ui_secret" {
  path      = "${vault_mount.grafana.path}/grafana-ui-secret"
  data_json = file(".secrets/grafana-ui-secret.json")
}
