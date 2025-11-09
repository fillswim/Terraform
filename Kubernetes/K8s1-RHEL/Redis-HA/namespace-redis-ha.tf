# ==============================================================================
#                               Redis HA Namespace
# ==============================================================================

resource "kubernetes_namespace" "redis_ha_namespace" {

  metadata {

    annotations = {
      name = "redis-ha-namespace-annotation"
    }

    labels = {
      mylabel = "redis-ha"
    }

    name = "redis-ha"

  }
}