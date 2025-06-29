variable "cluster_name" {
    default = "lab-k8"
}
variable "project_name" {
    default = "lab-exercise"
}
variable "environment" {
    default = "dev"
}
variable "common_tags" {
    default = {
        Project = "lab-exercise"
        Environment = "dev"
        Terraform = true
    }
}