# Вывести путь для политики аутентификации kubernetes
output "vault_auth_backend_kubernetes_path" {
  value = vault_auth_backend.kubernetes.path
}