terraform {
  required_providers {
    google = {
      version = "~>5.45"
      source  = "hashicorp/google"
    }
  }
  backend "gcs" {
    bucket = "spot-terraform-state"
    prefix = "alpine-chrome"
  }
}

locals {
  project = "test-ai-243511"
  region  = "us-west1"
}

provider "google" {
  project = local.project
  region  = local.region
}

# Cloud Build trigger for alpine-chrome images
resource "google_cloudbuild_trigger" "alpine_chrome_build" {
  name        = "alpine-chrome-build"
  description = "Build and push alpine-chrome Docker images to Artifact Registry"

  github {
    owner = "spotai"
    name  = "alpine-chrome"
    push {
      branch = "^master$"
    }
  }

  filename = "cloudbuild.yml"

  tags = ["alpine-chrome", "docker", "security-update"]
}