# Добавить метод аутентификации по паролю
resource "vault_auth_backend" "example" {
  type = "userpass"
}

# Добавить полилитику для разработчиков
resource "vault_policy" "developer_policy" {
  name   = "developers"
  policy = file("policies/developer_policy.hcl")
}

# # Включить механизм KV2 для папки "developers"
resource "vault_mount" "developers" {
  path        = "developers"
  type        = "kv-v2"
  description = "KV2 Secrets Engine for Developers."
}

# Создать секрет для разработчика
resource "vault_generic_secret" "developer_sample_data" {
  path = "${vault_mount.developers.path}/test_account"

  data_json = <<EOT
{
  "username": "foo",
  "password": "bar"
}
EOT
}