/* Private subnet */
resource "aws_subnet" "PrivateSubnet" {
  cidr_block = "10.0.201.0/24"
  vpc_id = data.aws_vpc.vpc.id
  availability_zone = "ap-south-1a"

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

/* Security Group */
resource "aws_security_group" "lambda_sg" {
  name        = "lambda_sg"
  vpc_id      = data.aws_vpc.vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

/* Lambda Function */
resource "aws_lambda_function" "lambda_function" {
  function_name    = "lambdafn"
  filename         = "payload.zip"
  source_code_hash = data.archive_file.PyLambda.output_base64sha256
  role             = data.aws_iam_role.lambda.arn
  handler          = "lambda_function.lambda_handler" 
  runtime          = "python3.9" 
  timeout          = 30
  vpc_config {
    security_group_ids = [aws_security_group.lambda_sg.id]
    subnet_ids         = [aws_subnet.private_subnet.id]
  }
}