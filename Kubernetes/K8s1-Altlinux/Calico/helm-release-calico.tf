# =====================================================
#                        Calico
# =====================================================
resource "helm_release" "calico" {

  depends_on = [
    kubernetes_namespace.tigera_operator
  ]

  name             = "calico"
  repository       = "https://docs.tigera.io/calico/charts"
  chart            = "tigera-operator"
  version          = "v3.30.3"
  namespace        = "tigera-operator"
  create_namespace = true

  values = [
    file("${path.module}/helm-values/calico-values-v3.30.3.yaml")
  ]
}
# =====================================================
