# ==============================================================================
#                        Kubernetes Secret для Cert-Manager
# ==============================================================================

# Создаем Kubernetes Secret c CA для Cert-Manager
resource "kubernetes_secret" "ca_key_pair" {

  type = "kubernetes.io/tls"

  metadata {
    name      = "ca-key-pair"
    namespace = "cert-manager"
  }

  data = {
    # Сертифика для Argo CD (argocd.crt)
    # "tls.crt" = tls_locally_signed_cert.argocd_locally_signed_cert.cert_pem
    "tls.crt" = data.terraform_remote_state.remote_state_tls_ca_certificate.outputs.ca_cert_pem

    # Закрытый ключ для Argo CD (argocd.key)
    # "tls.key" = tls_private_key.argocd_private_key.private_key_pem
    "tls.key" = data.terraform_remote_state.remote_state_tls_ca_certificate.outputs.ca_private_key_pem
  }

}

output "kubernetes_secret_details" {
  value = join("\n", [
    format("============================================================"),
    format("                  Kubernetes Secret Details                 "),
    format("============================================================"),
    format("Secret Name:        %s", kubernetes_secret.ca_key_pair.metadata[0].name),
    format("  Namespace:        %s", kubernetes_secret.ca_key_pair.metadata[0].namespace),
    format("============================================================"),
  ])
}