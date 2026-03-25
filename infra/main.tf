# terra block that sets the version
terraform {
    required_version = "v1.14.3"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0" # exact version: 2.32.33
    }
    
  }
}
provider "aws" {
  region = "us-east-1"
}
# sets aws as a required provider

# provider block for aws that sets the region

import {
  to = aws_cognito_user_pool.xpix
  id = "us-east-1_b9YWIiW7q"
}
import {
  to = aws_cognito_user_pool_client.xpix
  id = "us-east-1_b9YWIiW7q/7rqndnof5rsaq4jke8qv0rv2fr"
}