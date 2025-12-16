# =====================================================
#                        CNPG
# =====================================================
resource "helm_release" "cnpg" {

  # depends_on = [
  #   kubernetes_namespace.cnpg_namespace
  # ]

  name             = "cloudnativepg"
  repository       = "https://cloudnative-pg.github.io/charts"
  chart            = "cloudnative-pg"
  version          = "0.26.1"
  namespace        = var.namespace_name
  create_namespace = true

  # values = [
  #   file("${path.module}/helm-values/cnpg-values.yaml")
  # ]
}

output "helm_release_details" {
  value = join("\n", [
    format("============================================================"),
    format("                    Helm Release Details                    "),
    format("============================================================"),
    format("Helm Release Name:  %s", helm_release.cnpg.name),
    format("  Namespace:        %s", helm_release.cnpg.namespace),
    format("  Chart:            %s", helm_release.cnpg.chart),
    format("  Version:          %s", helm_release.cnpg.version),
    format("  Repository:       %s", helm_release.cnpg.repository),
    format("============================================================"),
  ])
}

# =====================================================
