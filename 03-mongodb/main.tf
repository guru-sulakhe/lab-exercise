resource "aws_instance" "mongodb" {
    name = local.resource_name
    ami = data.aws_ami.ami_info.id
    instance_type = var.instance_type
    vpc_security_group_ids = [local.public_subnet_id]
    user_data = file(mongodb.sh)
    tags = merge(
        var.common_tags,
        var.mongodb_tags,
        {
            Name = local.resource_name
        }
    )
}

resource "aws_route53_record" "www" {
  zone_id = var.zone_id
  name    = "mongodb"
  type    = "A"
  ttl     = 1
  records = [aws_instance.mongodb.public_ip]
}