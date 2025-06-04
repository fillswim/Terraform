
module "vault-minio" {

  source = "/home/fill/Terraform-Modules/HashiCorp-Vault/Secret"

  # ==========================================
  #                Vault Policy
  # ==========================================
  vault_policy_name = var.vault_policy_name
  vault_policy_file = var.vault_policy_file
  # ==========================================
  #        Папка c секретами в Vault
  # ==========================================
  vault_mount_path        = var.vault_mount_path
  vault_mount_type        = var.vault_mount_type
  vault_mount_description = var.vault_mount_description
  # ==========================================
  #                    Role
  # ==========================================
  vault_role_name                             = var.vault_role_name
  # Значение из переменной "vault_role_backend" = "kubernetes"
  # vault_role_backend                          = var.vault_role_backend
  # Значение из Outputs Remote State Vault
  vault_role_backend                          = data.terraform_remote_state.remote_state_vault_k8s1_rhel.outputs.vault_auth_backend_kubernetes_path
  vault_role_bound_service_account_names      = var.vault_role_bound_service_account_names
  vault_role_bound_service_account_namespaces = var.vault_role_bound_service_account_namespaces
  # ==========================================
  #                   Secret
  # ==========================================
  vault_secret_name = var.vault_secret_name
  vault_secret_file = var.vault_secret_file

}

output "details" {
  value = module.vault-minio.details
}
