#https://registry.terraform.io/providers/hashicorp/google/latest/docs

provider "google" {
  project     = "prj-2710-vi52166711vy-svc"
  region      = "europe-west1"
}

#https://developer.hashicorp.com/terraform/language/settings/backends/gcs

terraform {
  backend "gcs" {
    bucket  = "tf-state-prod"
    prefix  = "terraform/state"
  }
}
