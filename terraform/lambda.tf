//S3 BUCKET

resource "random_pet" "lambda_bucket_name" {
  prefix = "security-workshop-lambda"
  length = 4
}

resource "aws_s3_bucket" "lambda_bucket" {
  bucket = random_pet.lambda_bucket_name.id  
  force_destroy = true
}

//LAMBDA FUNCTION

data "archive_file" "lambda_security_workshop" {
  type = "zip"

  source_dir  = "${path.module}/lambda"
  output_path = "${path.module}/lambda.zip"
}

resource "aws_s3_object" "lambda_security_workshop" {
  bucket = aws_s3_bucket.lambda_bucket.id

  key    = "lambda_security_workshop.zip"
  source = data.archive_file.lambda_security_workshop.output_path

  etag = filemd5(data.archive_file.lambda_security_workshop.output_path)
}

resource "aws_lambda_function" "lambda_security_workshop" {
  function_name = "securityWorkshop"

  s3_bucket = aws_s3_bucket.lambda_bucket.id
  s3_key    = aws_s3_object.lambda_security_workshop.key

  runtime = "nodejs18.x"
  handler = "index.handler"

  source_code_hash = data.archive_file.lambda_security_workshop.output_base64sha256

  role = aws_iam_role.lambda_security_workshop_role.arn
}

resource "aws_cloudwatch_log_group" "lambda_security_workshop" {
  name = "/aws/lambda/${aws_lambda_function.lambda_security_workshop.function_name}"

  retention_in_days = 3
}

resource "aws_iam_role" "lambda_security_workshop_role" {
  name = "securityWorkshopLambda"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_security_workshop_policy" {
  role       = aws_iam_role.lambda_security_workshop_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.lambda_security_workshop.function_name}"
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the API Gateway "REST API".
  source_arn = "${aws_api_gateway_rest_api.security_workshop.execution_arn}/*/*"
}