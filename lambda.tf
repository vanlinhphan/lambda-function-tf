locals {
  lambda-zip-location = "outputs/functionbasic.zip"
}
data "archive_file" "init" {
  type        = "zip"
  source_file = "functionbasic.py"
  output_path = local.lambda-zip-location
}

resource "aws_lambda_function" "test_lambda" {
  filename      = local.lambda-zip-location
  function_name = "functionbasic"
  role          = aws_iam_role.lambda_role.arn
  handler       = "functionbasic.hello"

  source_code_hash = filebase64sha256(local.lambda-zip-location)

  runtime = "python3.7"

}
