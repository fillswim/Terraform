# =====================================================
#                     Cert-Manager
# =====================================================
resource "helm_release" "rancher" {

  depends_on = [
    kubernetes_manifest.rancher_secret_tls
  ]

  name             = "rancher"
  repository       = "https://releases.rancher.com/server-charts/stable"
  chart            = "rancher"
  version          = "2.12.2"
  namespace        = "cattle-system"
  create_namespace = true

  values = [
    file("${path.module}/helm-values/rancher-stable-values.yaml")
  ]
}
# =====================================================
