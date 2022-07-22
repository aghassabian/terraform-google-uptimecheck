terraform {
  required_version = ">=0.14"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0.0, < 5.0"
    }
  }
}