variable "project_name" {
    default = "lab-exercise"
}

variable "environment" {
    default = "dev"
}

variable "common_tags" {
    default = {
        Project = "lab-exercise"
        Terraform = true
        Environment = "dev"
    }
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
    default = ["10.0.3.0/24","10.0.4.0/24"]
}

variable "private_subnet_cidrs" {
    default = ["10.0.13.0/24","10.0.14.0/24"]
}

variable "database_subnet_cidrs" {
    default = ["10.0.23.0/24","10.0.24.0/24"]
}

variable "is_peering_required" {
    default = false
}