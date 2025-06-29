variable "project_name"{
    default = "lab-exercise"
}

variable "environment" {
    default = "dev"
}

variable "mongodb_tags" {
    default = {
        Component = "mongodb"
    }
}

variable "common_tags" {
    default = {
        Project = "lab-exercise"
        Environment = "dev"
        Terraform = true
    }
}

variable "instance_type" {
    default = "t3.micro"
}

variable "zone_id" {
    default = "Z08273698E2G6XTP9T7C"
}
