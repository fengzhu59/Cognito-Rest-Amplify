# Backend
This folder contains the terraform scripts for the backend. Currently it creates an S3 bucket where the lambda code is uploaded to, creates a lambda with the uploaded code and creates the necessary API Gateway resources in order to call the lambda.

## Initial setup required

- A free AWS account
- Configure the credentials on machine so that terraform can create resources in the AWS account
- In the **variables.tf** file specify the aws profile that terraform should use to create the resources

## Install the following tools

- Terraform

## Create resources in AWS using terraform

In a terminal go to the backend folder and run the following commands:

Initialise terraform:

`terraform init`

View the plan:

`terraform plan`

Create the resources:

`terraform apply`

Remember to destroy the resources once you are finished with these:

`terraform destroy`

## Test

- Open the AWS Console and go to **API Gateway**
- Select the **SecurityWorkshop** API
- Select the **GET** method
- Select the **Test** tab
- Click on the **Test** button
- You should see "Hello from Lambda!" from the response body
