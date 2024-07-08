# employeewebapp

![Employee Web App](https://github.com/rwatkins1/employeewebapp/assets/65431767/483e5392-bd1d-494b-9135-298b709f11a4)

## Overview
In this project, I took an existing project where the creator created this application using the console. I recreated it using infrastructure as code tool Terraform. This project aims to demonstrate how to automate the deployment of AWS infrastructure using IaC tools.

## Technologies Used
- AWS (VPC, EC2, S3, DynamoDB, IAM)
- IaC Tool (Terraform)
- VSCode

## Steps

### Step 1: Create the Virtual Network
- Custom VPC
- Route Table
- Public and Private Subnets
- Internet Gateway
- Associate Route Table
- Create Security Group

### Step 2: Create IAM Policies and Roles
- Create IAM Role that will grant EC2 permissions to access S3 and DynamoDB

### Step 3: Create EC2 Instances
- Launch in the correct VPC, subnet & AZ
- Add user data (update your S3 bucket and DynamoDB variables)
- Use correct security group

### Step 4: Create S3 Bucket
- Add bucket policy

### Step 5: Create DynamoDB Table


## Known Issues
- I did not design for high availability at the application layer to save no cost. If I were to add these components, I would add an application load balancer, auto scaling, launch a second ec2 instance in another AZ. 

## Future Improvements
I could improve this architeture by containerizing the application, making the application more lightweight. 




