
terraform {
 backend "gcs" {
   project = "comp698-lm2020"
   bucket  = "comp698-lm2020-terraform-state"
   prefix  = "terraform-state"
 }
}
provider "google" {
  region = "us-central1"
}