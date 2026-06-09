terraform {
  required_version = ">= 1.5"

  required_providers {
    random  = { source = "hashicorp/random",  version = "~> 3.6" }
    null    = { source = "hashicorp/null",    version = "~> 3.2" }
    local   = { source = "hashicorp/local",   version = "~> 2.5" }
    time    = { source = "hashicorp/time",    version = "~> 0.11" }
    tls     = { source = "hashicorp/tls",     version = "~> 4.0" }
  }
}

# 300 random strings
resource "random_string" "s" {
  count   = 300
  length  = 16
  special = false
  upper   = false
}

# 200 random pets
resource "random_pet" "p" {
  count     = 200
  length    = 2
  separator = "-"
}

# 150 random ids
resource "random_id" "id" {
  count       = 150
  byte_length = 8
}

# 100 random integers
resource "random_integer" "n" {
  count = 100
  min   = 1
  max   = 100000
}

# 100 random passwords
resource "random_password" "pw" {
  count   = 100
  length  = 24
  special = true
}

# 50 random uuids
resource "random_uuid" "u" {
  count = 50
}

# 100 null_resources with triggers referencing other resources
resource "null_resource" "trig" {
  count = 100
  triggers = {
    pet = random_pet.p[count.index % 200].id
    str = random_string.s[count.index % 300].result
  }
}

# 100 time_static
resource "time_static" "t" {
  count = 100
}

# 50 time_offset
resource "time_offset" "exp" {
  count       = 50
  offset_days = count.index + 1
}

# 30 tls keys (small bits = fast; this is the slowest part)
resource "tls_private_key" "k" {
  count     = 30
  algorithm = "ED25519"
}

# 30 self-signed certs paired to the keys
resource "tls_self_signed_cert" "c" {
  count           = 30
  private_key_pem = tls_private_key.k[count.index].private_key_pem
  subject {
    common_name  = random_pet.p[count.index].id
    organization = "iacm-noop"
  }
  validity_period_hours = 24
  allowed_uses          = ["digital_signature"]
}

# A few outputs (not counted as resources)
output "total_strings" { value = length(random_string.s) }
output "sample_pet"    { value = random_pet.p[0].id }
output "first_cert_cn" { value = tls_self_signed_cert.c[0].subject[0].common_name }
