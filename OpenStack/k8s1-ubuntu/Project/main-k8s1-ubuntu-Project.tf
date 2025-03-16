
module "k8s1-ubuntu-project" {
  # source = "/home/fill/Terraform-Modules/OpenStack/Project"
  source = "github.com/fillswim/Terraform-Modules/OpenStack/Project"

  project_name     = "k8s1-ubuntu"
  user_name        = "k8s1-ubuntu"
  user_password    = "123qweasd"
}
