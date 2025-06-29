module "bastion" {
    source = "terraform-aws-modules/ec2-instance/aws"

    ami = data.aws_ami.ami_info.id
    name = local.resource_name
    instance_type = "t3.micro"
    vpc_security_group_ids = [local.bastion_sg_id]
    subnet_id = local.public_subnet_id
    user_data = file("bastion.sh")

    tags = merge(
        var.common_tags,
        var.bastion_tags,
        {
            Name = local.resource_name
        }
    )
}

#login to bastion once infra is created
# $ aws configure
# $ aws eks update-kubeconfig --region us-east-1 --name lab-exercise-dev