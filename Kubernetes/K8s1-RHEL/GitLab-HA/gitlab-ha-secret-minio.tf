# ==============================================================================
#                              MinIO Auth Secret for GitLab
# ==============================================================================

resource "kubernetes_secret" "minio_auth_secret" {

  depends_on = [kubernetes_namespace.gitlab_ha_namespace]

  metadata {
    name      = var.minio-auth-secret-name
    namespace = var.namespace_name
  }

  data = {
    (var.minio-password-key) = var.minio-password-value
  }

}
