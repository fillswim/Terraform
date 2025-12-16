# ==============================================================================
#                                    Secret Names
# ==============================================================================


variable "gitlab-auth-secret-name" {
  type = string
}

variable "postgresql-auth-secret-name" {
  type = string
}

variable "redis-auth-secret-name" {
  type = string
}


# ==============================================================================
#                                    Secret Data
# ==============================================================================

variable "gitlab-admin-password-key" {
  type = string
}

variable "gitlab-admin-password-value" {
  type = string
}

variable "postgresql-user-password-key" {
  type = string
}

variable "postgresql-user-password-value" {
  type = string
}

variable "redis-password-key" {
  type = string
}

variable "redis-password-value" {
  type = string
}

# ==============================================================================
#                                   MinIO Auth Secret
# ==============================================================================

variable "minio-auth-secret-name" {
  type = string
}

variable "minio-password-key" {
  type = string
}

variable "minio-password-value" {
  type = string
}

# ==============================================================================
#                            GitLab Initial Root Password
# ==============================================================================

variable "gitlab-initial-root-secret-name" {
  type = string
}

variable "gitlab-initial-root-password-key" {
  type = string
}

variable "gitlab-initial-root-password-value" {
  type = string
}