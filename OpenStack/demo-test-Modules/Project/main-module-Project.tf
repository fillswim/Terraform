
module "demo-test-project" {
  source = "/home/fill/Terraform-Modules/OpenStack/Project"
  # source = "github.com/fillswim/Terraform-Modules/OpenStack/Project"

  project_name     = "demo-test"
  user_name        = "demo-test"
  user_password    = "123qweasd"
}
