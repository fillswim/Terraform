# ==============================================================================
#                              Сохранение Сертификата Argo CD
# ==============================================================================

# Имя папки для сохранения сертификатов
variable "folder_name" {
  type    = string
  default = ".certs"
}

# Создать папку для сгенерированных файлов
resource "null_resource" "create_folder" {
  provisioner "local-exec" {
    command = "mkdir -p ${path.module}/${var.folder_name}"
  }
}

# Закрытый ключ Argo CD (argocd.key)
resource "local_file" "cert_key_pem" {
  content  = module.argocd_certificate.private_key_pem
  filename = "${path.module}/${var.folder_name}/argocd.key"
}

# Сертификат Argo CD (argocd.crt)
resource "local_file" "cert_pem" {
  content  = module.argocd_certificate.cert_pem
  filename = "${path.module}/${var.folder_name}/argocd.crt"
}
