#project
variable "projectPrefix" {
    description = "prefix for resources"
}
variable "GCP_PROJECT_ID" {
  description = "project where resources are created"
}
# env
variable "GCP_REGION" {
  description = "default region"
}
variable "GCP_ZONE" {
  description = "default zone"
}

# admin 
variable "adminSrcAddr" {
  description = "admin source range in CIDR x.x.x.x/24"
}

variable "adminAccount" {
  description = "admin account name"
}
variable "adminPass" {
  description = "admin account password"
}
variable "gce_ssh_pub_key_file" {
  description = "ssh public key for instances"
}

variable "sa-file" {
  description = "cloud service account json"
}

# app
variable "instanceCount" {
  description = "number of instances"
}
variable "appName" {
  description = "app name"
  default = "app"
}