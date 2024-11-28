resource "vault_auth_backend" "kubernetes" {
  type = "kubernetes"
}

resource "vault_kubernetes_auth_backend_config" "kubernetes" {
  backend                = vault_auth_backend.kubernetes.path
  kubernetes_host        = "https://kubernetes.default.svc:443"
  kubernetes_ca_cert     = file(".certs/ca.crt")
  token_reviewer_jwt     = file(".certs/token")
  issuer                 = "https://kubernetes.default.svc.cluster.local"
  disable_iss_validation = "true"
}