provider "google" {
  credentials = "${file("account.json")}"
  project     = "my-gce-project-id"
  region      = "us-central1"
}

// Create a new instance
resource "google_compute_instance_template" "webser" {
	name = "${var.name}-webser-instance-template"
	machine_type = "${var.instance_type} "
	zone = "${var.region}"


	disk{
		image = "${var.image}"
	}

	network_interface {
    	network = "${var.network_name}"
    	access_config {
      		# Ephemeral IP - leaving this block empty will generate a new external IP and assign it to the machine
    }
  }
}