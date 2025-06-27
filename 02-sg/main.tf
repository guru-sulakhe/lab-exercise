module "mongdb_sg" {
    source = "git::https://github.com/guru-sulakhe/terraform-aws-security-group.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    common_tags = var.common_tags
    sg_name = "mongodb_sg"
    vpc_id = local.vpc_id
    sg_tags = var.mongodb_sg_tags
}

module "node_sg" {
    source = "git::https://github.com/guru-sulakhe/terraform-aws-security-group.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    common_tags = var.common_tags
    sg_name = "node_sg"
    vpc_id = local.vpc_id
}

module "eks_control_plane_sg" {
    source = "git::https://github.com/guru-sulakhe/terraform-aws-security-group.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    common_tags = var.common_tags
    sg_name = "eks_control_plane_sg"
    vpc_id = local.vpc_id
}

resource "aws_security_group_rule" "node_eks_control_plane" {
    type = "ingress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    source_security_group_id = module.eks_control_plane_sg.id
    security_group_id = module.node_sg.id
}

resource "aws_security_group_rule" "node_vpc" {
    type = "ingress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["10.0.0.0/16"]
    security_group_id = module.node_sg.id
}

resource "aws_security_group_rule" "eks_control_plane_node" {
    type = "ingress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    source_security_group_id = module.node_sg.id
    security_group_id = module.eks_control_plane_sg.id
}

resource "aws_security_group_rule" "mongodb_node"{
    type = "ingress"
    from_port = 27017
    to_port = 27017
    protocol = "tcp"
    source_security_group_id = module.node_sg.id
    security_group_id = module.mongodb_sg.id
}
