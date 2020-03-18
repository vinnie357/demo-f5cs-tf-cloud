#project
variable "projectPrefix" {
    description = "prefix for resources"
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
# app
variable "instanceCount" {
  description = "number of instances"
}
