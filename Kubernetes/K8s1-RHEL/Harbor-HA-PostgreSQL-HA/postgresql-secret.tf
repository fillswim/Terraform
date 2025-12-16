# ==============================================================================
#                              PostgreSQL Auth Secret
# ==============================================================================

resource "kubernetes_secret" "postgresql_auth_secret" {

  depends_on = [kubernetes_namespace.postgresql_namespace]

  metadata {
    name      = var.secret_name
    namespace = var.namespace_name
  }

  data = {
    admin-password       = var.admin-password
    user-password        = var.user-password
    replication-password = var.replication-password
  }

}
