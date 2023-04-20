/* Private subnet */
resource "aws_subnet" "PrivateSubnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id = data.aws_vpc.vpc.id

  tags = {
    Name = "private_subnet"
  }
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
  tags = {
    Name        = "PrivateRoute"    
  }
}

/* Lambda Function */
resource "aws_lambda_function" "lambda_function" {
  function_name    = "lambda_function"
  filename         = "payload.zip"
  source_code_hash = data.archive_file.PyLambda.output_base64sha256
  handler          = "lambda_function.lambda_handler"
  role             = data.aws_iam_role.lambda.arn
  runtime          = "python3.7" 
}