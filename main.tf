terraform {
  required_providers {
    random = {
      source  = "registry.terraform.io/hashicorp/random"
      version = "~> 3.6"
    }
  }
}

resource "random_pet" "demo" {
  length = 2
}
resource "terraform_data" "demo" {
}
