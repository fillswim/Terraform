# ==============================================================================
#                               Minio for Mimir Secret
# ==============================================================================

resource "kubernetes_secret" "minio_for_mimir_secret" {

  # depends_on = [kubernetes_namespace.mimir_namespace]

  metadata {
    name      = var.minio_for_mimir_secret_name
    namespace = var.namespace_name
  }

  data = {
    (var.access-key-key) = var.access-key-value
    (var.secret-key-key) = var.secret-key-value
  }

}
