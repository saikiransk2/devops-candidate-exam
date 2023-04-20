/* Private subnet */
resource "aws_subnet" "PrivateSubnet" {
  cidr_block = "10.0.224.0/24"
  vpc_id = data.aws_vpc.vpc.id

}

/* archive */
data "archive_file" "PyLambda" {  
  type = "zip"  
  source_file = "${path.module}/payload.py" 
  output_path = "payload.zip"
}

/* Routing table for private subnet */
resource "aws_route_table" "PrivateRoute" {
  vpc_id = data.aws_vpc.vpc.id  
}

/* Lambda Function */
resource "aws_lambda_function" "lambda_function" {
  function_name    = "lambda_function"
  filename         = "payload.zip"
  source_code_hash = data.archive_file.PyLambda.output_base64sha256
  role             = data.aws_iam_role.lambda.arn
  handler          = "lambda_function.lambda_handler" 
  runtime          = "python3.7" 
  timeout          = 40
}