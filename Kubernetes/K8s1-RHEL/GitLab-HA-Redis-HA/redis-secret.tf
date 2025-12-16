# ==============================================================================
#                               Redis Auth Secret
# ==============================================================================

resource "kubernetes_secret" "redis_auth_secret" {

  depends_on = [kubernetes_namespace.redis_namespace]

  metadata {
    name      = var.secret_name
    namespace = var.namespace_name
  }

  data = {
    redis-password = var.redis-password
  }

}