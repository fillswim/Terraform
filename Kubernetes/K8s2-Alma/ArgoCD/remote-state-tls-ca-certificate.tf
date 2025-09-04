
# Откуда будет браться .tfstate развертывания "TLS-CA-Certificate"

data "terraform_remote_state" "remote_state_tls_ca_certificate" {
  backend = "s3"
  config = {
    bucket                      = "terraform-state"
    key                         = "tls-ca-certificate/terraform.tfstate"
    region                      = "main"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    use_path_style              = true
  }
}
