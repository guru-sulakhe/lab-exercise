# Output the S3 bucket ARN and the EC2 instance ID
output "s3_bucket_arn" {
  value = aws_s3_bucket.mongo_backups/backups.arn
}

output "ec2_instance_id" {
  value = aws_instance.mongodb.id
}