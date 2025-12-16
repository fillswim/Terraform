# ==============================================================================
#                              Harbor Auth Secret
# ==============================================================================

resource "kubernetes_secret" "harbor_auth_secret" {

  depends_on = [kubernetes_namespace.harbor_ha_namespace]

  metadata {
    name      = var.harbor-auth-secret-name
    namespace = var.namespace_name
  }

  data = {
    (var.harbor-admin-password-key) = var.harbor-admin-password-value
  }

}
