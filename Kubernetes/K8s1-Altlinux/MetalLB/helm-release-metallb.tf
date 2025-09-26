# =====================================================
#                        MetalLB
# =====================================================
resource "helm_release" "metallb" {
  name             = "metallb"
  repository       = "https://metallb.github.io/metallb"
  chart            = "metallb"
  version          = "0.15.2"
  namespace        = "metallb-system"
  create_namespace = true

  values = [
    file("${path.module}/helm-values/metallb-my-values-0.15.2.yaml")
  ]
}
# =====================================================
