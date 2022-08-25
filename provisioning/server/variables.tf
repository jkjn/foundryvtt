variable "key_name" {
    type = string
    description = "Name of the key pair to allow access to the instance"
}
variable "user_access_security_group_name" {
    type = string
    description = "Name of the user access group, manually configured in the console"
}
variable "default_prefix" {
    type = string
    description = "Default prefix to apply to resources"
}
variable "region" {
    type = string
    description = "Region to apply resources in"
    default = "us-east-2"
}
variable "availability_zone" {
    type = string
    description = "Availability zone"
    default = "us-east-2a"
}
variable "environment" {
    type = string
    description = "The environment we're deploying in"
}
variable "root_dns" {
    type = string
    description = "Name of the root DNS"
    default = null
}