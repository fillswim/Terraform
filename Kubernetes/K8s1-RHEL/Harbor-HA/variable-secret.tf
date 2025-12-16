# ==============================================================================
#                                    Secret Names
# ==============================================================================


variable "harbor-auth-secret-name" {
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

variable "harbor-admin-password-key" {
  type = string
}

variable "harbor-admin-password-value" {
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
