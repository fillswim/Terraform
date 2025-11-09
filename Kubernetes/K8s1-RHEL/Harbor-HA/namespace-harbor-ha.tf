# ==============================================================================
#                              Harbor HA Namespace
# ==============================================================================

resource "kubernetes_namespace" "harbor_ha_namespace" {

  metadata {

    annotations = {
      name = "harbor-ha-namespace-annotation"
    }

    labels = {
      mylabel = "harbor-ha"
    }

    name = "harbor-ha"

  }
}