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

  metadata {
    gce-container-declaration = <<EOF
spec:
  containers:
    - image: 'gcr.io/comp698-lm2020/github-lmukanovic-webser:9b34b174c28bf886eb50948c53d42b290e9ea8e3'
      name: service-container
      stdin: false
      tty: false
  restartPolicy: Always
EOF
  }
  
  tags = ["http-server"]  

  

    service_account {
    scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/devstorage.read_write",
    ]
  }


    
  disk {
  source_image = "cos-cloud/cos-stable"
  }
        
  machine_type         = "n1-standard-1"
    network_interface {
    network = "default"
    access_config {
    }
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
