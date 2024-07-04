# employeewebapp

## Overview
In this project, I took an existing project that can be found on AWS's Skill Builder and recreated it using infrastructure as code. This project aims to demonstrate how to automate the deployment of AWS infrastructure using IaC tools.

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
- Detailed table setup

## Deployment
To deploy this infrastructure, follow these steps:
1. [Step-by-step instructions]
2. [Commands and configurations]

## Testing and Validation
- [Testing methods and results]

## Challenges
- [Challenges and solutions]

## Known Issues
- [Issues and limitations]

## Future Improvements
- [Suggestions for future improvements]

## License
- [License information]



