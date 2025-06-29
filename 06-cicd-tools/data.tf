data "aws_ssm_parameter" "private_subnet_ids" {
    name = "/${var.project_name}/${var.environment}-private_subnet_ids"
}

data "aws_ami" "ami_info" {

    owners = ["973714476881"]
    most_recent = true

    filter {
        name = "name"
        values = ["RHEL-9-DevOps-Practic"]
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

