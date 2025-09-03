# # Вывод пользовательского сертификата (cert.pem)
# output "cert_pem" {
#   value = tls_locally_signed_cert.example.cert_pem
# }

# # Вывод сертификата CA (ca-cert.pem)
# output "ca-cert_pem" {
#   value = tls_locally_signed_cert.example.ca_cert_pem
# }

# # Вывод закрытого ключа пользовательского сертификата (cert-key.pem)
# output "cert-key_pem" {
#   value = nonsensitive(tls_private_key.example.private_key_pem)
# }
