variable "project_name" {
    default = "roboshop"
}
variable "environment"{
    default = "prod"
}
variable "common_tags" {
    default = {
        Project = "roboshop"
        Environment = "prod"
        Terraform = true
    }
}
variable "mongodb_sg_tags"{
    default = {
        Component = "mysql"
    }
}
variable "bastion_sg_tags" {
    default = {
        Component = "bastion"
    }
}
variable "frontend_sg_tags" {
    default = {
        Component = "frontend"
    }
}