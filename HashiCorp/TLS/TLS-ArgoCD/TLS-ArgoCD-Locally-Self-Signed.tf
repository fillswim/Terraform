# ==============================================================================
#                              Сертификат, подписанный CA
# ==============================================================================

# module "argocd_certificate" {

#   source = "/home/fill/Terraform-Modules/HashiCorp/TLS/CA-Self-Signed/v1"

#   algorithm             = var.algorithm
#   rsa_bits              = var.rsa_bits
#   common_name           = var.common_name
#   organization          = var.organization
#   dns_names             = var.dns_names
#   ca_private_key_pem    = file(var.ca_private_key_pem_path)
#   ca_cert_pem           = file(var.ca_cert_pem_path)

# }

# ==============================================================================
#                             Самоподписанный сертификат
# ==============================================================================

module "argocd_certificate" {

  source = "/home/fill/Terraform-Modules/HashiCorp/TLS/Simple-Self-Signed/v1"

  algorithm             = var.algorithm
  rsa_bits              = var.rsa_bits
  common_name           = var.common_name
  organization          = var.organization
  dns_names             = var.dns_names

}

# ==============================================================================
#                              Kubernetes Secret для Argo CD
# ==============================================================================

# Создаем Kubernetes Secret для Argo CD
resource "kubernetes_secret" "argo_cd_secret" {

  type = "kubernetes.io/tls"

  metadata {
    name      = "argo-cd-tls"
    namespace = "argo-cd"
  }

  data = {
    # Сертифика для Argo CD (argocd.crt)
    # "tls.crt" = tls_locally_signed_cert.argocd_locally_signed_cert.cert_pem
    "tls.crt" = module.argocd_certificate.cert_pem

    # Закрытый ключ для Argo CD (argocd.key)
    # "tls.key" = tls_private_key.argocd_private_key.private_key_pem
    "tls.key" = module.argocd_certificate.private_key_pem
  }

}


























# # ==============================================================================

# variable "folder_name" {
#   type    = string
#   default = ".generated"
# }

# # Создать папку для сгенерированных файлов
# resource "null_resource" "create_folder" {
#   provisioner "local-exec" {
#     command = "mkdir -p ${path.module}/${var.folder_name}"
#   }
# }

# resource "local_file" "cert_pem" {
#   content  = tls_locally_signed_cert.example.cert_pem
#   filename = "${path.module}/${var.folder_name}/cert.pem"
# }

# resource "local_file" "ca_cert_pem" {
#   content  = tls_locally_signed_cert.example.ca_cert_pem
#   filename = "${path.module}/${var.folder_name}/ca-cert.pem"
# }

# resource "local_file" "cert_key_pem" {
#   content  = tls_private_key.example.private_key_pem
#   filename = "${path.module}/${var.folder_name}/private_key.pem"
# }
