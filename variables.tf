variable "name" {
  description = "A name for the trail, ideally the same value you used for the bucket name prefix"
  type        = string
}

variable "s3_bucket" {
  description = "The name od the S3 bucket you created to store the logs"
  type        = string
}
