terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 5.8"
        }
    }
    backend "s3" {
        bucket = "guru97s-remote-state"
        key = "lab-exercise-infra-dev-ecr"
        region = "us-east-1"
        dynamodb_table = "guru97s-locking-dynamodb"
    }
}
provider "aws" {
    region = "us-east-1"
}