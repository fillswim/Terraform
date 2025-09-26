resource "kubernetes_manifest" "ClusterIssuer" {

  depends_on = [kubernetes_secret.ca_key_pair]
  manifest   = yamldecode(file("${path.module}/k8s-manifests/ClusterIssuer.yaml"))

}
