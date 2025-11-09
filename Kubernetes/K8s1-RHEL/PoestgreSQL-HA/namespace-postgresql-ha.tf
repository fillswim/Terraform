# ==============================================================================
#                              PostgreSQL HA Namespace
# ==============================================================================

resource "kubernetes_namespace" "postgresql_ha_namespace" {

  metadata {

    annotations = {
      name = "postgresql-ha-namespace-annotation"
    }

    labels = {
      mylabel = "postgresql-ha"
    }

    name = "postgresql-ha"

  }
}