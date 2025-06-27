locals {
  private_subnet_ids = split(",", data.aws_ssm_parameter.private_subnet_ids.values)[0]
  node_sg_id = data.aws_ssm_parameter.node_sg_id.value
  eks_control_plane_sg_id = data.aws_ssm_parameter.eks_control_plane_sg_id.value
}
