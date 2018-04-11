terraform {
 backend "gcs" {
   project = "comp698-lm2020"
   bucket  = "comp698-lm2020-terraform-state"
   prefix  = "terraform-state"
 }
}
provider "google" {
  credentials = ""
  project     = "comp698-lm2020"
  region = "us-central1"
}
//instances
resource "google_compute_instance" "webser"{
        name = "terraform-webservers"
        description = "Terraform test instance group-1"
        machine_type = " "
        zone = "us-central1"



        network_interface {
        network = "default"
        access_config {
                104.197.78.154
                // ?Empheral IP
        }
}

        count = 1
        lifecyle = {
                create_before_destroy = true
        }

        //instances = [
   // "${google_compute_instance.test.self_link}",

 // ]
}
