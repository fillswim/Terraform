resource "vault_generic_secret" "developer_sample_data" {
  path = "kv-v2/test/test-account"

  data_json = <<EOT
{
  "username": "foo",
  "password": "bar"
}
EOT
}