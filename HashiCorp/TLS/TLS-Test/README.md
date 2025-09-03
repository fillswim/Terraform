# Центр Сертификации (CA)

## Для Terraform

### Закрытый ключ Центра Сертификации (ca-key.pem) 
```bash
openssl genrsa -out ca-key.pem
```
### Сертификат Центра Сертификации (ca-cert.pem) 

Создать сертификат Центра Сертификации (ca-cert.pem) для закрытого ключа Центра сертификации (ca-key.pem):
```bash
openssl req -new -x509 -sha256 \
    -days 365 \
    -key ca-key.pem \
    -subj "/C=CA/ST=MOSCOW/L=MOSCOW/O=LOCAL/OU=MYORG/CN=FILLSWIM" \
    -out ca-cert.pem
```