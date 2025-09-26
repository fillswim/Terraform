resource "kubernetes_manifest" "L2Advertisement" {
  manifest = yamldecode(file("${path.module}/k8s-manifests/MetalLB_L2Advertisement.yaml"))
}

resource "kubernetes_manifest" "IPAddressPool" {
  depends_on = [kubernetes_manifest.L2Advertisement]
  manifest   = yamldecode(file("${path.module}/k8s-manifests/MetalLB_IPAddressPool.yaml"))
}
