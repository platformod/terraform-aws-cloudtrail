provider "aws" {
  region = "us-east-2"
  default_tags {
    tags = {
      Environment = "Test"
      Repo        = "platformod/terraform-aws-cloudtrail"
      CI          = true
    }
  }
}

variables {
  name = "test-8388737"
}

run "gets" {
  module {
    source = "./tests/gets"
  }
}

run "bucket" {
  variables {
    account_trails = [
      {
        account = run.gets.account_id,
        arn     = "arn:aws:cloudtrail:us-east-2:${run.gets.account_id}:trail/${var.name}"
      }
    ]
  }
  module {
    source = "platformod/cloudtrail-s3/aws"
    version = "1.0.1"
  }
}

run "apply" {
  command = apply

  variables {
    s3_bucket = "${var.name}-cloudtrail"
  }

  assert {
    condition     = aws_cloudtrail.trail.home_region == "us-east-2"
    error_message = "Trail not created in correct region"
  }

  assert {
    condition     = aws_cloudtrail.trail.arn == "arn:aws:cloudtrail:us-east-2:${run.gets.account_id}:trail/${var.name}"
    error_message = "Trail ARN.  It ain't right"
  }
}
