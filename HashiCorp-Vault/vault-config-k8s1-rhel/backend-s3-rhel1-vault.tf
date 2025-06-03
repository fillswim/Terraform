terraform {
  backend "s3" {
    bucket = "terraform-state"
    key    = "vault-config-k8s1-rhel/terraform.tfstate" # ! Необхожимо изменить для каждой папки !
    region = "main"

    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    use_path_style              = true
  }
}