variable "project_name" {
    default = "roboshop"
}

variable "environment" {
    default = "prod"
}

variable "common_tags" {
    default = {
        Project = "roboshop"
        Terraform = true
        Environment = "prod"
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