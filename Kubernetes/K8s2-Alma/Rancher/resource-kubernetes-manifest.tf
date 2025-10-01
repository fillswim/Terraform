resource "kubernetes_manifest" "rancher_namespace" {

  manifest   = yamldecode(file("${path.module}/k8s-manifests/rancher-namespace.yaml"))

}

resource "kubernetes_manifest" "rancher_secret_tls" {

  depends_on = [kubernetes_manifest.rancher_namespace]
  manifest   = yamldecode(file("${path.module}/k8s-manifests/rancher-certificate.yaml"))

}
