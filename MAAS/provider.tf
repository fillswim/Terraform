terraform {
  required_providers {
    maas = {
      source  = "canonical/maas"
      version = "2.6.0"
    }
  }
}


provider "maas" {
  api_version = "2.0"
  api_key     = "58K3unuMG9wFP8RKPf:7LmXmEq9rwkBdSJQmV:KLBmk3RY9kNvrAH34kzfPwmcXMT4acBZ"
  api_url     = "http://192.168.42.35:5240/MAAS"

  installation_method = "snap"
}