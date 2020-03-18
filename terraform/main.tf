# provider
provider "google" {
  #credentials = "${file("../${path.root}/creds/gcp/${var.GCP_SA_FILE_NAME}.json")}"
  credentials = "${var.sa-file}"
  project     = "${var.GCP_PROJECT_ID}"
  region      = "${var.GCP_REGION}"
  zone        = "${var.GCP_ZONE}"
}
# project
resource "random_pet" "buildSuffix" {
  keepers = {
    # Generate a new pet name each time we switch to a new AMI id
    #ami_id = "${var.ami_id}"
    prefix = "${var.projectPrefix}"
  }
  #length = ""
  #prefix = "${var.projectPrefix}"
  separator = "-"
}
# network
resource "google_compute_network" "vpc_network_ext" {
  name                    = "${var.projectPrefix}terraform-network-ext-${random_pet.buildSuffix.id}"
  auto_create_subnetworks = "false"
  routing_mode = "REGIONAL"
}
resource "google_compute_subnetwork" "vpc_network_ext_sub" {
  name          = "${var.projectPrefix}ext-sub-${random_pet.buildSuffix.id}"
  ip_cidr_range = "10.0.30.0/24"
  region        = "us-east1"
  network       = "${google_compute_network.vpc_network_ext.self_link}"

}
# firewall
resource "google_compute_firewall" "default-allow-internal-ext" {
  name    = "${var.projectPrefix}default-allow-internal-ext-firewall-${random_pet.buildSuffix.id}"
  network = "${google_compute_network.vpc_network_ext.name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  priority = "65534"

  source_ranges = ["10.0.30.0/24"]
}
resource "google_compute_firewall" "app" {
  name    = "${var.projectPrefix}app-firewall${random_pet.buildSuffix.id}"
  network = "${google_compute_network.vpc_network_ext.name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "443","4000"]
  }

  source_ranges = ["${var.adminSrcAddr}"]
}
# workloads
module "application" {
  source   = "./application"
  #======================#
  # application settings #
  #======================#
  name = "${var.appName}"
  gce_ssh_pub_key_file = "${var.gce_ssh_pub_key_file}"
  adminAccountName = "${var.adminAccount}"
  ext_vpc = "${google_compute_network.vpc_network_ext}"
  ext_subnet = "${google_compute_subnetwork.vpc_network_ext_sub}"
  projectPrefix = "${var.projectPrefix}"
  buildSuffix = "-${random_pet.buildSuffix.id}"
  instanceCount = "${var.instanceCount}"
}
