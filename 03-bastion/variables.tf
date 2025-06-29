variable "project_name" {
    default = "lab-exercise"
}
variable "environment" {
    default = "dev"
}
variable "common_tags" {
    default = {
        Project = "roboshop"
        Terraform = true
        Environment = "dev"
    }
}
variable "bastion_tags" {
    default = {
        Component = "bastion"
    }
}
