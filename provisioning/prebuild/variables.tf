variable "default_prefix" {
    type = string
    description = "Default prefix to apply to resources"
}
variable "environment" {
    type = string
    description = "The environment to deploy to"
}
variable "root_dns" {
    type = string
    description = "Root domain name"
}