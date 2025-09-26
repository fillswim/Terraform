# =====================================================
#                     Cert-Manager
# =====================================================
resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  # repository       = "oci://quay.io/jetstack/charts/cert-manager"
  repository       = "oci://quay.io/jetstack/charts"
  chart            = "cert-manager"
  version          = "v1.18.2"
  namespace        = "cert-manager"
  create_namespace = true

  values = [
    file("${path.module}/helm-values/cert-manager-values.yaml")
  ]
}
# =====================================================
