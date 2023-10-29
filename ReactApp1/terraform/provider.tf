terraform {
  backend "s3" {
    bucket         = "sanyo123bucketss"
    region         = "us-east-1"
    key            = "backend1.tfstate"
    dynamodb_table = "sanyo123tables"
  }
}

provider "aws" {
  region = "us-east-1"
}