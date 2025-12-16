# ==============================================================================
#                                  SuperUser Secret
# ==============================================================================


variable "superuser-secret-name" {
  type = string
}

variable "superuser-password-key" {
  type = string
}

variable "superuser-password-value" {
  type = string
}

variable "superuser-username-key" {
  type = string
}

variable "superuser-username-value" {
  type = string
}

# ==============================================================================
#                                User Secret
# ==============================================================================


variable "user-secret-name" {
  type = string
}

variable "user-password-value" {
  type = string
}

variable "user-password-key" {
  type = string
}

variable "user-username-key" {
  type = string
}

variable "user-username-value" {
  type = string
}

# ==============================================================================
#                               Minio for CNPG Secret
# ==============================================================================

variable "minio_for_cnpg_secret_name" {
  type = string
}

variable "access-key-key" {
  type = string
}

variable "secret-key-key" {
  type = string
}

variable "access-key-value" {
  type = string
}

variable "secret-key-value" {
  type = string
}
