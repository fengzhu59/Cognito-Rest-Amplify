resource "aws_api_gateway_rest_api" "security_workshop" {
  name        = "SecurityWorkshop"
  description = "Security Workshop API Gateway"
}

resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = "${aws_api_gateway_rest_api.security_workshop.id}"
  parent_id   = "${aws_api_gateway_rest_api.security_workshop.root_resource_id}"
  path_part   = "helloWorld"
}

resource "aws_api_gateway_method" "proxy" {
  rest_api_id   = "${aws_api_gateway_rest_api.security_workshop.id}"
  resource_id   = "${aws_api_gateway_resource.proxy.id}"
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id = "${aws_api_gateway_rest_api.security_workshop.id}"
  resource_id = "${aws_api_gateway_method.proxy.resource_id}"
  http_method = "${aws_api_gateway_method.proxy.http_method}"

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.lambda_security_workshop.invoke_arn}"
}

resource "aws_api_gateway_deployment" "security_workshop" {
  depends_on = [
    aws_api_gateway_integration.lambda_integration
  ]

  rest_api_id = "${aws_api_gateway_rest_api.security_workshop.id}"
  stage_name  = "test"
}