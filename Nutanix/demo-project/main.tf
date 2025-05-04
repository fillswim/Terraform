resource "nutanix_vpc_v2" "vpc" {
  name        = "terraform-vpc"
  description = "Terraform VPC"
}

data "nutanix_cluster" "cluster" {
  name = "NUTANIX-1"
}

output "cluster_id" {
  value = data.nutanix_cluster.cluster.id
}

resource "nutanix_subnet_v2" "subnet" {
  name              = "test-overlay-subnet"
  vpc_reference     = nutanix_vpc_v2.vpc.id
  subnet_type       = "OVERLAY"
  ip_config {
    ipv4 {
      ip_subnet {
        ip {
          value = "10.1.0.0"
        }
        prefix_length = 24
      }
      default_gateway_ip {
        value = "10.1.0.1"
      }
      pool_list {
        start_ip {
          value = "10.1.0.2"
        }
        end_ip {
          value = "10.1.0.254"
        }
      }
    }
  }
  dhcp_options {
    domain_name_servers {
        ipv4 {
          value = "8.8.8.8"
        }
    }
  }
}

