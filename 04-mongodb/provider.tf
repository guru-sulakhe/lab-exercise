terraform {
    required_providers {
        aws = {
            source = "5.64.0"
            region = "us-east-1"
        }
    }
    backend "s3" {
        bucket = "guru97s-remote-state"
        key = "lab-exercise-infra-mongodb"
        region = "us-east-1"
        dynamodb_table = "guru97s-locking-dynamodb"
    }
}