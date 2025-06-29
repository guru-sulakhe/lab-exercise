resource "aws_ecr_repository" "frontend" {
  name                 = "${var.project_name}/${var.environment}/frontend"
  image_tag_mutability = "MUTABLE"
  force_delete = true
  image_scanning_configuration {
    scan_on_push = true
  }
}
