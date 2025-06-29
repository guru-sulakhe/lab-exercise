resource "aws_ssm_parameter" "mongodb_sg_id" {
    name = "/${var.project_name}/${var.environment}-mongodb_sg_id"
    type = "String"
    value = module.mongodb_sg.id 
}

resource "aws_ssm_parameter" "node_sg_id" {
    name = "/${var.project_name}/${var.environment}-node_sg_id"
    type = "String"
    value = module.node_sg.id
}

resource "aws_ssm_parameter" "eks_control_plane_sg_id" {
    name = "/${var.project_name}/${var.environment}-eks_control_plane_sg_id"
    type = "String"
    value = module.eks_control_plane_sg.id
}

resource "aws_ssm_parameter" "bastion_sg_id" {
    name = "/${var.project_name}/${var.environment}-bastion_sg_id"
    type = "String"
    value = module.bastion_sg.id
}


