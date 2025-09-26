# =====================================================
#                        Cilium
# =====================================================
resource "helm_release" "cilium" {
  name       = "cilium"
  repository = "https://helm.cilium.io"
  chart      = "cilium"
  version    = "1.17.5"
  namespace  = "kube-system"

  values = [
    file("${path.module}/helm-values/cilium-my-values-1.17.5.yaml")
  ]
}
# =====================================================