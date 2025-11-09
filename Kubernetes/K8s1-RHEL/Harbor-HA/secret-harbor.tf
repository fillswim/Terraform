# ==============================================================================
#                              Harbor Auth Secret
# ==============================================================================

resource "kubernetes_secret" "harbor_auth_secret" {

  depends_on = [kubernetes_namespace.harbor_ha_namespace]

  metadata {
    name      = "harbor-auth-secret"
    namespace = "harbor-ha"
  }

  data = {
    admin-password = var.harbor-admin-password
  }

}
