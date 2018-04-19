terraform {
backend "gcs" {
	project = "comp698-lm2020"
	bucket  = "comp698-lm2020-terraform-state"
	prefix  = "terraform-state"
 }
}

provider "google" {
  project = "comp698-lm2020"
  region = "us-central1"
}


//instances
resource "google_compute_instance_template" "terraform-webserver"{
  name = "terraform-webserver"
  project     = "comp698-lm2020"
    
  disk {
  source_image = "cos-cloud/cos-stable"
  }
        
  machine_type         = "n1-standard-1"
    network_interface {
    network = "default"
  }     
}

resource "google_compute_instance_group_manager" "default" {
name               = "tf-lm-webser-manager"
project = "comp698-lm2020"
instance_template  = "${google_compute_instance_template.terraform-webserver.self_link}"
base_instance_name = "app"
zone               = "us-central1-f"
target_size        = "2"
}


resource "google_storage_bucket" "image-store" {
  project  = "comp698-lm2020"
  name     = "lmukanovicisfrombugojnobosnia"
  location = "us-central1"
}
