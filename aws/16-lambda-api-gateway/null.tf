resource "null_resource" "invoke_lambda" {
  provisioner "local-exec" {
    command = "aws lambda invoke --region=us-east-1 --function-name=${aws_lambda_function.hello_world.function_name} response.json"
  }
  depends_on = [aws_lambda_function.hello_world]
}

resource "null_resource" "curl_command" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "curl \"$(terraform output -raw base_url)/hello?Name=MyName\""
  }

  depends_on = [aws_apigatewayv2_stage.lambda]
}

