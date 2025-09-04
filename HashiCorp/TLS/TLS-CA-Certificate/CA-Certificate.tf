# ==============================================================================
#                      Сертификат Корневого Центра Сертификации (CA)
# ==============================================================================

# 1. Генерация приватного ключа корневого CA
resource "tls_private_key" "ca_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# 2. Самоподписанный сертификат корневого CA
resource "tls_self_signed_cert" "ca_self_signed_cert" {

  private_key_pem = tls_private_key.ca_private_key.private_key_pem

  subject {
    common_name  = "My Root CA"
    organization = "Example Org"
  }

  is_ca_certificate     = true
  validity_period_hours = 87600 # ~10 лет
  allowed_uses = [
    "cert_signing",
    "key_encipherment",
    "digital_signature",
  ]
}

# ==============================================================================
#           Сохранение Сертификата Корневого Центра Сертификации (CA)
# ==============================================================================

variable "certs_folder_name" {
  type    = string
  default = ".certs"
}

# Создать папку для сгенерированных файлов
resource "null_resource" "create_folder" {
  provisioner "local-exec" {
    command = "mkdir -p ${path.module}/${var.certs_folder_name}"
  }
}

# Сохранить Закрытый ключ Центра Сертификации (CA) (ca.key)
resource "local_file" "ca_key_pem" {
  content  = tls_private_key.ca_private_key.private_key_pem
  filename = "${path.module}/${var.certs_folder_name}/ca.key"
}

# Сохранить Сертификат корневого Центра Сертификации (CA) (ca.crt)
resource "local_file" "ca_cert_pem" {
  content  = tls_self_signed_cert.ca_self_signed_cert.cert_pem
  filename = "${path.module}/${var.certs_folder_name}/ca.crt"
}

# ==============================================================================
#           Output Сертификата Корневого Центра Сертификации (CA)
# ==============================================================================

output "ca_private_key_pem" {
  value     = tls_private_key.ca_private_key.private_key_pem
  sensitive = true
}

output "ca_cert_pem" {
  value     = tls_self_signed_cert.ca_self_signed_cert.cert_pem
  sensitive = true
}
