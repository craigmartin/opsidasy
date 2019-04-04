provider "aws" {
  region = "us-west-2"
}


# variables

variable "lambda_version"     { default = "1.0.0"}
variable "s3_bucket"          { default = "facepalm-bucket"}

