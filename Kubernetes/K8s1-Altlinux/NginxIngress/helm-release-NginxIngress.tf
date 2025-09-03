# =====================================================
#                        MetalLB
# =====================================================
resource "helm_release" "NginxIngress" {
  name             = "ingress-nginx"
  # repository       = "oci://ghcr.io/nginx/charts/nginx-ingress"
  repository       = "oci://ghcr.io/nginx/charts"
  chart            = "nginx-ingress"
  version          = "2.2.2"
  namespace        = "ingress-nginx"
  create_namespace = true

  values = [
    file("${path.module}/NginxIngress-values.yaml")
  ]
}
# =====================================================
