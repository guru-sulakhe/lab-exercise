variable "project_name" {
    default = "lab-exercise"
}
variable "environment"{
    default = "dev"
}
variable "common_tags" {
    default = {
        Project = "lab-exercise"
        Environment = "prod"
        Terraform = true
    }
}
variable "mongodb_sg_tags"{
    default = {
        Component = "mongodb"
    }
}
