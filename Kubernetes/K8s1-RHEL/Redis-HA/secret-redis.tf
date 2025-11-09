# ==============================================================================
#                               Redis Auth Secret
# ==============================================================================

resource "kubernetes_secret" "redis_auth_secret" {

  depends_on = [kubernetes_namespace.redis_ha_namespace]

  metadata {
    name      = "redis-auth-secret"
    namespace = "redis-ha"
  }

  data = {
    redis-password = var.redis-password
  }

}