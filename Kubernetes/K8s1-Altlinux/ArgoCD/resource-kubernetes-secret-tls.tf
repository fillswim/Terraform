# ==============================================================================
#                              Kubernetes Secret для Argo CD
# ==============================================================================

# Создаем Kubernetes Secret для Argo CD
resource "kubernetes_secret" "argo_cd_secret" {

  depends_on = [
    kubernetes_namespace.argo_cd,
    module.argocd_certificate
  ]

  type = "kubernetes.io/tls"

  metadata {
    name      = "argo-cd-tls"
    namespace = "argo-cd"
  }

  data = {
    # Сертифика для Argo CD (argocd.crt)
    # "tls.crt" = tls_locally_signed_cert.argocd_locally_signed_cert.cert_pem
    "tls.crt" = module.argocd_certificate.cert_pem

    # Закрытый ключ для Argo CD (argocd.key)
    # "tls.key" = tls_private_key.argocd_private_key.private_key_pem
    "tls.key" = module.argocd_certificate.private_key_pem
  }

}

output "kubernetes_secret_details" {
  value = join("\n", [
    format("============================================================"),
    format("                  Kubernetes Secret Details                 "),
    format("============================================================"),
    format("Secret Name:        %s", kubernetes_secret.argo_cd_secret.metadata[0].name),
    format("  Namespace:        %s", kubernetes_secret.argo_cd_secret.metadata[0].namespace),
    format("============================================================"),
  ])
}