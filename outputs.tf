output "terraform-state-bucket-name" {
    description = "The name of the project's state bucket"
    value = aws_s3_bucket.terraform-demo-project-terraform-state.id
}