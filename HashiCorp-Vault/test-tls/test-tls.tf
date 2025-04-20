# Создание приватного ключа пользовательского сертификата
resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Создание запроса к пользовательскому сертификату
resource "tls_cert_request" "example" {
  private_key_pem = tls_private_key.example.private_key_pem

  ip_addresses = [ "192.168.2.30", "192.168.2.31", "192.168.2.32", "192.168.2.33", "192.168.2.34", "192.168.2.35", "192.168.2.36" ]

  dns_names = [ "minio.fillswim.local", "*.minio.fillswim.local" ]

  subject {
    common_name  = "fillswim.local"
    organization = "My Organization"
  }
}

resource "tls_locally_signed_cert" "example" {
  # Закрытый ключ Центра Сертификации (CA)
  ca_private_key_pem = file("/home/fill/certs/ca-key.pem")
  # Сертификат Центра Сертификации (CA)
  ca_cert_pem        = file("/home/fill/certs/ca-cert.pem")
  # Запрос сертификата
  cert_request_pem   = tls_cert_request.example.cert_request_pem

  # Срок действия (в часах)
  validity_period_hours = 8760

  # Разрешенные использования
  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}