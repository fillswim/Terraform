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

output "kubernetes_namespace_details" {
  value = join("\n", [
    format("============================================================"),
    format("                Kubernetes Namespace Details                "),
    format("============================================================"),
    format("Namespace:          %s", kubernetes_namespace.argo_cd.metadata[0].annotations.name),
    format("============================================================"),
  ])
}