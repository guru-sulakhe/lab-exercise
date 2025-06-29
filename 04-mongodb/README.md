# 🛠️ Terraform Setup: MongoDB on EC2 with Public S3 Backup Storage

This Terraform module provisions an **EC2 instance running MongoDB**, sets up a **public S3 bucket** for storing backups, and creates all required **IAM policies and roles** for access. It also creates a **Route 53 DNS record** to easily resolve the MongoDB instance by name.

---

## Components Created

### 1. **S3 Bucket for Backups**
# resource "aws_s3_bucket" "mongodb_backups/backups"

* Bucket Name: mongodb_backups/backups
* ACL: public-read
* Purpose: To store MongoDB database backups

## Public Access Enabled ##
resource "aws_s3_bucket_public_access_block" "public_access"
* Disables public access restrictions so the bucket contents can be read publicly.

## Public Access Policy ##
* Grants public read (s3:GetObject, s3:ListBucket) and write (s3:PutObject) access.

## IAM Role and Policy for EC2 access S3 bucket
* Allows EC2 to list and retrieve objects from the S3 bucket.

## Creating EC2 instance for MongoDB Server
* Automatically provisions an EC2 instance using:

* A public SSH key (~/.ssh/tools.pub)

* A user data script (mongodb.sh)

* Security group and subnet variables

* IAM instance profile for S3 access

## Route 53 Record for MongoDB

* DNS: mongodb.<domain-name> → EC2 instance public IP

* TTL: 1 (for near-instant DNS propagation)

## File Dependencies
* mongodb.sh – A shell script to install and start MongoDB on the EC2 instance

* ~/.ssh/tools.pub – Your generated public SSH key

 
