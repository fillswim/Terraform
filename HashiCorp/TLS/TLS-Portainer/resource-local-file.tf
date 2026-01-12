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

# Закрытый ключ Proxmox 5 (proxmox5.key)
resource "local_file" "cert_key_pem" {
  content  = module.portainer_certificate.private_key_pem
  filename = "${path.module}/${var.folder_name}/portainer_key.pem"
}

# Сертификат Proxmox 5 (proxmox5.crt)
resource "local_file" "cert_pem" {
  content  = module.portainer_certificate.cert_pem
  filename = "${path.module}/${var.folder_name}/portainer_cert.pem"
}
