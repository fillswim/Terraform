# ==============================================================================
#                              GitLab Auth Secret
# ==============================================================================

resource "kubernetes_secret" "harbor_auth_secret" {

  depends_on = [kubernetes_namespace.gitlab_ha_namespace]

  metadata {
    name      = var.gitlab-auth-secret-name
    namespace = var.namespace_name
  }

  data = {
    (var.gitlab-admin-password-key) = var.gitlab-admin-password-value
  }

}
