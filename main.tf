terraform {
  backend "s3" {
    bucket = "rahulcliharness"
    key    = "harness/test_s3/terraform.tfstate"
    region = "eu-north-1"
  }

  required_providers {
    random = {
      source  = "registry.opentofu.org/hashicorp/random"
      version = "~> 3.6"
    }
  }
}

resource "random_pet" "demo" {
  length = 2
}

resource "terraform_data" "demo" {
}
