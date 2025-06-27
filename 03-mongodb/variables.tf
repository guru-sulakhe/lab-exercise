variable "project_name"{
    default = "lab-exercise"
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