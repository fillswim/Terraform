
# Откуда будет браться .tfstate развертывания HashiCorp Vault кластера Л8ы1 RHEL

data "terraform_remote_state" "remote_state_vault_k8s1_rhel" {
  backend = "s3"
  config = {
    bucket                      = "terraform-state"
    key                         = "vault-config-k8s1-rhel/terraform.tfstate"
    region                      = "main"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    use_path_style              = true
  }
}