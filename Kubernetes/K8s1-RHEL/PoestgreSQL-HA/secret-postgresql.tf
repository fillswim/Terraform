# ==============================================================================
#                              PostgreSQL Auth Secret
# ==============================================================================

resource "kubernetes_secret" "postgresql_auth_secret" {

  depends_on = [kubernetes_namespace.postgresql_ha_namespace]

  metadata {
    name      = "postgresql-auth-secret"
    namespace = "postgresql-ha"
  }

  data = {
    admin-password       = var.admin-password
    user-password        = var.user-password
    replication-password = var.replication-password
  }

}
