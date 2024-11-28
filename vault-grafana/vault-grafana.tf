
data "vault_auth_backend" "kubernetes" {
  path = "kubernetes"
}

# Добавить полилитику для разработчиков
resource "vault_policy" "grafana_ui_secret_policy" {
  name   = "grafana-ui-secret-policy"
  policy = file("policies/grafana-ui-secret-policy.hcl")
}

# Включить механизм KV2 для папки "grafana"
resource "vault_mount" "grafana" {
  path        = "grafana"
  type        = "kv-v2"
  description = "KV2 Secrets Engine for Grafana"
}

# Создание роли для доступа к секрету Grafana 
resource "vault_kubernetes_auth_backend_role" "grafana_ui_secret_role" {
  backend                          = data.vault_auth_backend.kubernetes.path
  role_name                        = "grafana-ui-secret-role"
  bound_service_account_names      = ["default"]
  bound_service_account_namespaces = ["grafana"]
  token_ttl                        = 86400 # 24 часа 
  token_policies                   = ["default", vault_policy.grafana_ui_secret_policy.name]
  audience                         = "vault"
}

# Создать секрет для Grafana UI
resource "vault_generic_secret" "grafana_ui_secret" {
  path      = "${vault_mount.grafana.path}/grafana-ui-secret"
  data_json = file(".secrets/grafana-ui-secret.json")
}
