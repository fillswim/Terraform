resource "kubernetes_namespace" "tigera_operator" {

  metadata {
    annotations = {
      name = "tigera-operator"
    }

    labels = {
      mylabel = "tigera-operator"
    }

    name = "tigera-operator"
  }
  
}