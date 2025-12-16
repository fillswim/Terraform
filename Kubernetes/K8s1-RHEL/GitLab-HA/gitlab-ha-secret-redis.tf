# ==============================================================================
#                              Redis Auth Secret for GitLab
# ==============================================================================

resource "kubernetes_secret" "redis_auth_secret" {

  depends_on = [kubernetes_namespace.gitlab_ha_namespace]

  metadata {
    name      = var.redis-auth-secret-name
    namespace = var.namespace_name
  }

  data = {
    (var.redis-password-key) = var.redis-password-value
  }

}
