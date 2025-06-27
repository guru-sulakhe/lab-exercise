terraform {
    required_providers {
        aws = {
            source = 
            region = "us-east-1"
        }
    }
    backend "s3" {
        bucket = 
        key = 
        region = "us-east-1"
        dynamodb_table =
    }
}