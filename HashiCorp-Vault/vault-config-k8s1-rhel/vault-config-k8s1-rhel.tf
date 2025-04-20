# ================================= S3 Backend =================================
terraform {
  backend "s3" {
    bucket = "terraform-state"
    key    = "vault-config-k8s1-rhel/terraform.tfstate" # ! Необхожимо изменить для каждой папки !

    # endpoints = {
    #   s3 = "http://api.minio.fillswim.local"
    # }

    region = "main"

    # access_key = "admin-username"
    # secret_key = "admin-password"

    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    use_path_style              = true

  }
}

# Включить Kubernetes Auth Backend

resource "vault_auth_backend" "kubernetes" {
  type = "kubernetes"
}

# Настроить Kubernetes Auth Backend

resource "vault_kubernetes_auth_backend_config" "kubernetes" {
  backend                = vault_auth_backend.kubernetes.path
  kubernetes_host        = "https://kubernetes.default.svc:443"
  kubernetes_ca_cert     = file(".certs/ca.crt")
  token_reviewer_jwt     = file(".certs/token")
  issuer                 = "https://kubernetes.default.svc.cluster.local"
  disable_iss_validation = "true"
}