data "aws_ssm_parameter" "mongodb_sg" {
    name = "/${var.project_name}/${var.environment}-mongodb_sg"
}
data "aws_ssm_parameter" "public_subnet_ids" {
    name = "/${var.project_name}/${var.environment}-public_subnet_ids"
}
data "aws_ami" "ami_info" {
    
    most_recent = true
    owners = ["973714476881"]

    filter {
        name = "name"
        values = ["RHEL-9-DevOps-Practice"]
    }
    filter {
        name = "root-device-type"
        values = ["ebs"]
    }
    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
}