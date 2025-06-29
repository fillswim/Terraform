# ===============================================
#             Generate Template Settings
# ===============================================

variable "folder_name" {
  type    = string
  default = "generated"
}

variable "template_file_name" {
  type    = string
  default = "user_data.tmpl"
}

variable "user_data_file_name" {
  type    = string
  default = "user_data.yaml"
}

# ===============================================
#                user_data Settings
# ===============================================

variable "cloud_user_username" {
  type    = string
  default = "cloud-user"
}

variable "password_hash" {
  type    = string
}

variable "ssh_public_keys_1" {
  type    = string
}

variable "ssh_public_keys_2" {
  type    = string
}

variable "ssh_public_keys_3" {
  type    = string
}

variable "ssh_public_keys_4" {
  type    = string
}

variable "timezone" {
  type    = string
  default = "Europe/Moscow"
}