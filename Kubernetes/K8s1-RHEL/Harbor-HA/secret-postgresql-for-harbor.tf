# ==============================================================================
#                              PostgreSQL Auth Secret for Harbor
# ==============================================================================

resource "kubernetes_secret" "postgresql_auth_secret_for_harbor" {

  depends_on = [kubernetes_namespace.harbor_ha_namespace]

  metadata {
    name      = "postgresql-auth-secret-for-harbor"
    namespace = "harbor-ha"
  }

  data = {
    password = var.postgresql-user-password
  }

}
