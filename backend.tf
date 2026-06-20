terraform {
  backend "s3" {
    bucket         = "danieledaniele3005-lesson-5-tfstate"
    key            = "lesson-5/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
