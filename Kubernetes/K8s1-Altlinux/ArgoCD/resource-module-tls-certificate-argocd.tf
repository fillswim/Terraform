


# ==============================================================================
#                              Сертификат, подписанный CA
# ==============================================================================

module "argocd_certificate" {

  source = "/home/fill/Terraform-Modules/HashiCorp/TLS/CA-Self-Signed/v1"

  algorithm             = var.algorithm
  rsa_bits              = var.rsa_bits
  common_name           = var.common_name
  organization          = var.organization
  dns_names             = var.dns_names
  # ca_private_key_pem    = file(var.ca_private_key_pem_path)
  # ca_cert_pem           = file(var.ca_cert_pem_path)
  ca_private_key_pem    = data.terraform_remote_state.remote_state_tls_ca_certificate.outputs.ca_private_key_pem
  ca_cert_pem           = data.terraform_remote_state.remote_state_tls_ca_certificate.outputs.ca_cert_pem

}

# ==============================================================================
#                             Самоподписанный сертификат
# ==============================================================================

# module "argocd_certificate" {

#   source = "/home/fill/Terraform-Modules/HashiCorp/TLS/Simple-Self-Signed/v1"

#   algorithm             = var.algorithm
#   rsa_bits              = var.rsa_bits
#   common_name           = var.common_name
#   organization          = var.organization
#   dns_names             = var.dns_names

# }

# # ==============================================================================
