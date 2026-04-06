resource "aws_s3_bucket" "xpix-photos-26w-25036501" {
  tags = {
    name = "xpix-photos"
  }
}
resource "aws_dynamodb_table" "dbtable" {
  name = "xpix-photos"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "photo_id"
  stream_enabled = true
  stream_view_type = "NEW_IMAGE"

  attribute {
    name = "photo_id"
    type = "S"
  }
  attribute {
    name = "user_id"
    type = "S"
  }
  attribute {
    name = "uploaded_at"
    type = "S"
  }
  attribute {
    name = "feed_key"
    type = "S"
  }

  global_secondary_index {
    name = "user-photos-index"
    hash_key = "user_id"
    range_key = "uploaded_at"
    projection_type = "ALL"
  }
  global_secondary_index {
    name = "feed-index"
    hash_key = "feed_key"
    range_key = "uploaded_at"
    projection_type = "ALL"
  }
}
resource "aws_ssm_parameter" "bucketparam" {
  name = "/app/s3/xpix-photos-26w-25036501"
  type = "String"
  value = "bucket"
}
resource "aws_ssm_parameter" "dbparam" {
  name = "/app/dynamodb/dbtable"
  type = "String"
  value = "name"
}