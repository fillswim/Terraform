# =====================================================
#                        ArgoCD
# =====================================================
resource "helm_release" "argo-cd" {

  depends_on = [
    kubernetes_secret.argo_cd_secret
  ]

  name             = "argo-cd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "8.3.0"
  namespace        = "argo-cd"
  create_namespace = true

  values = [
    file("${path.module}/helm-values/argocd-values.yaml")
  ]
}

output "helm_release_details" {
  value = join("\n", [
    format("============================================================"),
    format("                    Helm Release Details                    "),
    format("============================================================"),
    format("Helm Release Name:  %s", helm_release.argo-cd.name),
    format("  Namespace:        %s", helm_release.argo-cd.namespace),
    format("  Chart:            %s", helm_release.argo-cd.chart),
    format("  Version:          %s", helm_release.argo-cd.version),
    format("  Repository:       %s", helm_release.argo-cd.repository),
    format("============================================================"),
  ])
}

# =====================================================
