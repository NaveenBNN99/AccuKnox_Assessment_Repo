resource "aws_ecr_repository" "my_repository" {
  name = "mapup-repo"
  force_delete = false
  image_scanning_configuration {
    scan_on_push = false
    
  }
}

output "repository_url" {
  value = aws_ecr_repository.my_repository.repository_url
}