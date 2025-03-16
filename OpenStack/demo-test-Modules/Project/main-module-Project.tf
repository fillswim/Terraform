
module "demo-test-project" {
  # source = "/home/fill/Terraform-Modules/OpenStack/Project"
  source = "github.com/fillswim/Terraform-Modules/OpenStack/Project"

  project_name     = "demo-test"
  user_name        = "demo-test"
  user_password    = "123qweasd"
  image_source_url = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
  image_name       = "Ubuntu 24.04 LTS"
}
