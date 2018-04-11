terraform {
backend "gcs" {
	project = "comp698-lm2020"
	bucket  = "comp698-lm2020-terraform-state"
	prefix  = "terraform-state"
 }
}

provider "google" {
  project     = "comp698-lm2020"
  region = "us-central1"
}


//instances
resource "google_compute_instance_template" "webser"{
        name = "terraform-webserver"

        }

        
        machine_type         = "f1-mico"

        disk {
        source_image = "cos-cloud/cos-stable"
        }


  	network_interface {
 	network = "default"
  }

       
}
resource "google_compute_instance_group_manager" instance_group_manager" 	{
name               = "instance-group-manager"
instance_template  = "${google_compute_instance_template instance_template.self_link}"
base_instance_name = "instance-group-manager"
zone               = "us-central1-f"
target_size        = "1"
}
