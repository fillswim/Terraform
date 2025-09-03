# =====================================================
#                        ArgoCD
# =====================================================
resource "helm_release" "argo-cd" {
  name             = "argo-cd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "8.3.0"
  namespace        = "argo-cd"
  create_namespace = true

  values = [
    file("${path.module}/argocd-values.yaml")
  ]
}
# =====================================================
