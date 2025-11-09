# ==============================================================================
#                              Redis Auth Secret for Harbor
# ==============================================================================

resource "kubernetes_secret" "redis_auth_secret_for_harbor" {

  depends_on = [kubernetes_namespace.harbor_ha_namespace]

  metadata {
    name      = "redis-auth-secret-for-harbor"
    namespace = "harbor-ha"
  }

  data = {
    REDIS_PASSWORD = var.redis-password
  }

}
