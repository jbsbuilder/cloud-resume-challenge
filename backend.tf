terraform {
  backend "s3" {
    bucket = "jaketerraformstate"
    key    = "s3/terraform.tfstate"
    region = "us-west-1"
  }
}

