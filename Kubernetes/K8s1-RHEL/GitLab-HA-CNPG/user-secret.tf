# ==============================================================================
#                                   CNPG Secret
# ==============================================================================

resource "kubernetes_secret" "user_secret" {

  # depends_on = [kubernetes_namespace.cnpg_namespace]

  metadata {
    name      = var.user-secret-name
    namespace = var.namespace_name
  }

  data = {
    (var.user-username-key) = var.user-username-value
    (var.user-password-key) = var.user-password-value
  }

}
