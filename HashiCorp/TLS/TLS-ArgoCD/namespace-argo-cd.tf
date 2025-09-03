resource "kubernetes_namespace" "argo_cd" {

  metadata {
    annotations = {
      name = "argo-cd"
    }

    labels = {
      mylabel = "argo-cd"
    }

    name = "argo-cd"
  }
}
