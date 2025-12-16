# ==============================================================================
#                                SuperUser Secret
# ==============================================================================

resource "kubernetes_secret" "superuser_secret" {

  # depends_on = [kubernetes_namespace.cnpg_namespace]

  metadata {
    name      = var.superuser-secret-name
    namespace = var.namespace_name
  }

  data = {
    (var.superuser-username-key) = var.superuser-username-value
    (var.superuser-password-key) = var.superuser-password-value
  }

}
