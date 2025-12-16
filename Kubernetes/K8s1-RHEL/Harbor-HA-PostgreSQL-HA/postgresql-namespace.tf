# ==============================================================================
#                              PostgreSQL HA Namespace
# ==============================================================================

resource "kubernetes_namespace" "postgresql_namespace" {

  metadata {

    annotations = {
      name = "${var.namespace_name}-namespace-annotation"
    }

    labels = {
      mylabel = "${var.namespace_name}-label"
    }

    name = var.namespace_name

  }
}
