# ==============================================================================
#                         PostgreSQL Auth Secret for GitLab
# ==============================================================================

resource "kubernetes_secret" "postgresql_auth_secret" {

  depends_on = [kubernetes_namespace.gitlab_ha_namespace]

  metadata {
    name      = var.postgresql-auth-secret-name
    namespace = var.namespace_name
  }

  data = {
    (var.postgresql-user-password-key) = var.postgresql-user-password-value
  }

}
