resource "kubernetes_namespace" "prometheus" {

  metadata {
    annotations = {
      name = "prometheus-annotation"
    }

    labels = {
      mylabel = "prometheus"
    }

    name = "prometheus"
  }

}