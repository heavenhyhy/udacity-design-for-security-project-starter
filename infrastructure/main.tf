### Upload to S3
resource "aws_s3_object" "free_recipe" {
  bucket        = aws_cloudformation_stack.s3.outputs["BucketNameRecipesFree"]
  key           = "free_recipe.txt"
  source        = "../recipes/free_recipe.txt"
  content_type  = "text/plain"
  etag          = filemd5("../recipes/free_recipe.txt") // no encryption so it's ok to use etag rather than source_hash
}

resource "aws_s3_object" "secret_recipe" {
  bucket        = aws_cloudformation_stack.s3.outputs["BucketNameRecipesSecret"]
  key           = "secret_recipe.txt"
  source        = "../recipes/secret_recipe.txt"
  content_type  = "text/plain"
  etag          = filemd5("../recipes/secret_recipe.txt") // no encryption so it's ok to use etag rather than source_hash
}