
module "k8s2-ubuntu-project" {

  source = "/home/fill/Terraform-Modules/OpenStack/Project"
  # source = "github.com/fillswim/Terraform-Modules/OpenStack/Project"

  project_name     = "k8s2-ubuntu"
  user_name        = "k8s2-ubuntu"
  user_password    = "123qweasd"
}

output "k8s2-ubuntu-project-details" {
  description = "Details of the created project"
  value = module.k8s2-ubuntu-project.details
}
