resource "null_resource" "invoke_lambda" {
  provisioner "local-exec" {
    command = "aws lambda invoke --region=${var.aws_region} --function-name=${aws_lambda_function.app.function_name} response.json"
  }
  depends_on = [aws_lambda_function.app]
}

resource "null_resource" "curl_command" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "sleep 60; curl \"$(terraform output -raw base_url)/hello?Name=MyName\""
  }

  depends_on = [aws_apigatewayv2_stage.lambda]
}