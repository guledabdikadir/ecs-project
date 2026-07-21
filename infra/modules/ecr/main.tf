resource "aws_ecr_repository" "main" {
  name                 = "ecs-project"
  image_tag_mutability = "MUTABLE"

}