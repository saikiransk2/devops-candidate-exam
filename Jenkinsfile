pipeline{
    agent any
    stages{
        stage("TF Init"){
            steps{
                echo "Executing Terraform Init"
                sh 'terraform init'
                echo "init success"
            }
        }
        stage("TF Validate"){
            steps{
                echo "Validating Terraform Code"
                sh 'terraform validate'
                echo "validate success"
            }
        }
        stage("TF Plan"){
            steps{
                echo "Executing Terraform Plan"
                sh 'terraform plan'
                echo "plan success"
            }
        }
        stage("TF Apply"){
            steps{
                echo "Executing Terraform Apply"
                sh 'terraform apply --auto-approve'
                echo "apply success"
            }
        }
        stage("Invoke Lambda"){
            steps{
                echo "Invoking your AWS Lambda"
                sh 'aws lambda invoke --function-name \"lambda_function\" --region \"ap-south-1\" --log-type Tail output.txt'
                echo "lambda success"
            }
        }
    }
}
