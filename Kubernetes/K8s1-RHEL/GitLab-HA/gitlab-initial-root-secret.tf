# ==============================================================================
#                            GitLab Initial Root Password
# ==============================================================================

resource "kubernetes_secret" "gitlab_initial_root_secret" {

  depends_on = [kubernetes_namespace.gitlab_ha_namespace]

  metadata {
    name      = var.gitlab-initial-root-secret-name
    namespace = var.namespace_name
  }

  data = {
    (var.gitlab-initial-root-password-key) = var.gitlab-initial-root-password-value
  }

}
