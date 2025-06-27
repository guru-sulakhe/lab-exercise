resource "aws_instance" "mongodb" {
    name = local.resource_name
    ami = data.aws_ami.ami_info.id
    instance_type = var.instance_type
    vpc_security_group_ids = [local.public_subnet_id]
    tags = merge(
        var.common_tags,
        var.mongodb_tags,
        {
            Name = local.resource_name
        }
    )
}