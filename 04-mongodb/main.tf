#creating s3 bucket to store mongodb-backups
resource "aws_s3_bucket" "mongodb_backups/backups" {
  bucket = "mongodb_backups/backups"
  acl    = "public-read"

  tags = {
    Name        = "mongodb_backups/backups"
    Environment = "Dev"
  }
}

#Creating s3 bucket public access
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.mongodb_backups/backups.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

#Creating s2 bucket policy for public read
resource "aws_s3_bucket_policy" "public_policy" {
  bucket = aws_s3_bucket.mongodb_backups/backups.id

  policy = jsonencode({
    Version = "2012-10-17"
        Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::${aws_s3_bucket.mongodb_backups/backups.id}",
          "arn:aws:s3:::${aws_s3_bucket.mongodb_backups/backups.id}/*"
        ]
      }
    ]
  })
}

# creating IAM Policy for EC2 Access to S3 Bucket
resource "aws_iam_policy" "s3_public_access_policy" {
  name        = "s3-public-access-policy"
  description = "Policy for EC2 to access public S3 bucket"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Resource = [
          aws_s3_bucket.public_bucket.arn,
          "${aws_s3_bucket.public_bucket.arn}/*"
        ]
      }
    ]
  })
}


# Creating IAM Role for EC2
resource "aws_iam_role" "ec2_s3_role" {
  name = "ec2-s3-access-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

#Attaching IAM Policy to Role
resource "aws_iam_role_policy_attachment" "ec2_s3_attach" {
  role       = aws_iam_role.ec2_s3_role.name
  policy_arn = aws_iam_policy.s3_public_access_policy.arn
}

#Creating IAM Instance Profile (to attach to EC2)
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-s3-profile"
  role = aws_iam_role.ec2_s3_role.name
}

#Uploading SSH Public Key to AWS
resource "aws_key_pair" "generated" { 
  key_name = "tools" 
  public_key = file("~/.ssh/tools.pub")
   }
#Creating mongodb ec2 VM, Attaching IAM role of ec2 access s3
resource "aws_instance" "mongodb" {
    name = local.resource_name
    ami = data.aws_ami.ami_info.id
    instance_type = var.instance_type
    key_name = aws_key_pair.generated.key_name
    subnet_id = local.public_subnet_id
    vpc_security_group_ids = [local.mongodb_sg]
    iam_instance_profile   = aws_iam_role.ec2_s3_role.name # Attach the IAM ROLE to the instance
    user_data = file(mongodb.sh)
    tags = merge(
        var.common_tags,
        var.mongodb_tags,
        {
            Name = local.resource_name
        }
    )
}

#Creating Route 53 Record
resource "aws_route53_record" "www" {
  zone_id = var.zone_id
  name    = "mongodb"
  type    = "A"
  ttl     = 1
  records = [aws_instance.mongodb.public_ip]
}

#ssh-keygen -t rsa -b 4096 -f ~/.ssh/tools
# ssh -i ~/.ssh/tools ec2-user@<public-ip>
