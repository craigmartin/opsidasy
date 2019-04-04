resource "aws_api_gateway_rest_api" "facepalm-api-gateway" {
  name        = "FacePalmAPI"
  description = "API to access facepalm application"
  body        = "${data.template_file.facepalm_api_swagger.rendered}"
}

data "template_file" facepalm_api_swagger{
  template = "${file("swagger.yaml")}"

  vars {
    get_lambda_arn = "${aws_lambda_function.get-tips-lambda.invoke_arn}"
    post_lambda_arn = "${aws_lambda_function.post-tips-lambda.invoke_arn}"
  }
}

resource "aws_api_gateway_deployment" "facepalm-api-gateway-deployment" {
  rest_api_id = "${aws_api_gateway_rest_api.facepalm-api-gateway.id}"
  stage_name  = "default"
}

output "url" {
  value = "${aws_api_gateway_deployment.facepalm-api-gateway-deployment.invoke_url}/api"
}