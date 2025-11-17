data "kubernetes_service_account" "vault" {
  metadata {
    name      = "vault"
    namespace = "vault"
  }
}

output "vault_sa_token" {
  value = data.kubernetes_service_account.vault
}
