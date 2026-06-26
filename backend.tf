# terraform {
#   backend "s3" {
#     bucket         = "danieledaniele3005-lesson-5-tfstate"
#     key            = "lesson-7/terraform.tfstate"
#     region         = "eu-central-1"
#     dynamodb_table = "terraform-locks"
#     encrypt        = true
#   }
# }