


# data "openstack_identity_project_v3" "project_1" {
#   name = "admin"
# }

# output "project_1" {
#   value = data.openstack_identity_project_v3.project_1
# }

# resource "null_resource" "list_instances" {
#   provisioner "local-exec" {
#     command = "openstack project list --format json > projects.json"
#   }
# }

# data "external" "example" {
#   program = ["bash", "-c", "source ~/credentials/admin-openrc.sh && openstack project list --format json"]
# }

# output "example" {
#   value = data.external.example
# }

# resource "null_resource" "run_command" {
#   # provisioner "remote-exec" {
#   #   inline = [ "openstack server list" ]
#   # }

#   data "external" "example" {
#     program = ["bash", "-c", "source ~/credentials/admin-openrc.sh && openstack project list --format json"]
#   }
# }

# resource "null_resource" "remote_command" {
#   connection {
#     type        = "ssh"
#     user        = "stack"
#     private_key = file("/home/fill/.ssh/id_ed25519")
#     host        = "192.168.42.11"
#   }

#   provisioner "remote-exec" {
#     inline = [
#       "uname -a",  # Ваша команда
#       "echo 'Hello from remote server' > ~/output.txt",
#       "source ~/credentials/admin-openrc.sh && openstack project list"
#     ]
#   }
# }

data "http" "openstack_projects" {
  # url = "http://192.168.42.11/identity"
  url = "http://192.168.42.11/compute/v2.1"
  request_headers = {
    "X-Auth-Token" = "gAAAAABnqgOTVzTTpSs9h8HsxdarDgafFMMvhmoA-yM2eM7jMFaFEzS5R6jKMJSw05U35V0VOOvNDmkY7sqNE0rXzMZ1q61XxPZoEuUIBfy-p-9-ZRZpSZzK5Ldj6VnBlQA-6dPX0jbxBl20rIFzSbva_lgASs7VtRKt8NJeYzZ0nKtIogZqYp8"
  }
}

output "projects" {
  value = data.http.openstack_projects
}
