# **Cloud Resume Challenge**

This repository contains the code and configurations for the **Cloud Resume Challenge**, which involves building a serverless website using AWS services, Terraform, and continuous integration with Jenkins.

## **Table of Contents**

- [Project Overview](#project-overview)
- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
  - [Clone the Repository](#clone-the-repository)
  - [Terraform Setup](#terraform-setup)
  - [AWS Configuration](#aws-configuration)
  - [Jenkins Pipeline](#jenkins-pipeline)
- [Deployment](#deployment)
  - [1. Set Up AWS Resources](#1-set-up-aws-resources)
  - [2. Deploy the Website](#2-deploy-the-website)
  - [3. Configure API Gateway URL in `counter.js`](#3-configure-api-gateway-url-in-counterjs)
  - [4. Invalidate CloudFront Cache (If Applicable)](#4-invalidate-cloudfront-cache-if-applicable)
- [Usage](#usage)
- [Cleanup](#cleanup)
- [Project Structure](#project-structure)
- [License](#license)

## **Project Overview**

The Cloud Resume Challenge is a project that showcases your ability to build and deploy a serverless application using AWS services. This project includes:

- Hosting a static website on **Amazon S3** with a custom domain.
- Using **Amazon API Gateway** and **AWS Lambda** to implement a backend that tracks the number of visits to your website.
- Storing visitor count data in **Amazon DynamoDB**.
- Managing infrastructure as code with **Terraform**.
- Setting up continuous integration with **Jenkins**.

## **Architecture**

![Architecture Diagram](images/architecture-diagram.png)

*Note: Include an architecture diagram if possible to visually represent the components and their interactions.*

## **Prerequisites**

Before you begin, ensure you have the following installed:

- **Terraform** (v1.5.7 or later)
- **AWS CLI** (configured with appropriate access)
- **Python** (for Lambda function)
- **Jenkins** (set up for CI/CD pipeline)
- **Git**

## **Getting Started**

### **Clone the Repository**

```bash
git clone https://github.com/your-username/cloud-resume-challenge.git
cd cloud-resume-challenge
Terraform Setup
Initialize Terraform:```


Copy code
```bash
terraform init```
Review the Terraform Plan:


Copy code
```bash 
terraform plan```
Apply the Terraform Configuration:

Due to a dependency issue where the static bucket permissions try to attach before the bucket is created, you need to run terraform apply twice.

First Apply:


Copy code
```bash
terraform apply```
Second Apply:


Copy code
```bash
terraform apply```
Note: The first apply creates the S3 bucket, and the second apply attaches the necessary permissions once the bucket exists.

AWS Configuration
Ensure your AWS credentials are configured correctly. You can set them using environment variables or AWS CLI configuration files.
Jenkins Pipeline
A Jenkinsfile is provided to automate the deployment process.
The pipeline includes stages for initializing, planning, applying, and destroying Terraform configurations.
Parameters allow you to control which stages to execute.
Note: Ensure that Jenkins has the necessary AWS credentials configured and that the credentials ID matches the one used in the Jenkinsfile.
Deployment
1. Set Up AWS Resources
The Terraform scripts will create:

An S3 bucket for hosting the website.
A DynamoDB table for tracking visitor counts.
An API Gateway (HTTP API) with CORS configured.
A Lambda function that interacts with DynamoDB.
Necessary IAM roles and permissions.
2. Deploy the Website
Upload static files (index.html, resume.css, counter.js, 404.html) to the S3 bucket.
The files are managed via Terraform using aws_s3_object resources.
3. Configure API Gateway URL in counter.js
Update the API URL:

In your local website/counter.js file, replace the placeholder API URL with your actual API Gateway URL, appending /lambda_counter to the end.


Copy code
```javascript 
const apiUrl = 'https://your-api-id.execute-api.us-west-1.amazonaws.com/lambda_counter';```
Replace your-api-id with the actual API ID provided by AWS API Gateway.
This enables the visitor counter to communicate with your API.
Replace counter.js in the S3 Bucket:

After updating counter.js, you need to replace the existing counter.js file in your S3 bucket with the updated version to reflect the changes.
Steps to Replace counter.js in S3:

If you are managing your S3 objects via Terraform:

Ensure that the source_hash attribute in the aws_s3_object resource for counter.js is updated.


Copy code
```hcl
resource "aws_s3_object" "website_js" {
  bucket        = aws_s3_bucket.cloud_resume_challenge.id
  key           = "counter.js"
  source        = "website/counter.js"
  content_type  = "text/javascript"
  source_hash   = filemd5("website/counter.js")
  acl           = "public-read"
}```
Run terraform apply to update the object in S3.

If you are uploading manually:

Navigate to the S3 bucket in the AWS Management Console.
Upload the updated counter.js file, overwriting the existing one.
Ensure that the file permissions allow public read access.
4. Invalidate CloudFront Cache (If Applicable)
If you are using Amazon CloudFront as a CDN in front of your S3 bucket and you have updated files that are cached, you may need to invalidate the cache to force the distribution to serve the updated content.

Create a Cache Invalidation:

In the AWS Management Console, navigate to CloudFront.

Select your distribution and choose Invalidations.

Create a new invalidation and enter /* as the path.


Copy code
```bash
aws cloudfront create-invalidation --distribution-id YOUR_DISTRIBUTION_ID --paths "/*"```
This will invalidate all cached files, ensuring that users receive the latest version.

Usage
Access your website via the S3 bucket URL, CloudFront distribution, or your custom domain.
The visitor counter should display the number of visits, which is updated in real-time via the API Gateway and Lambda function.
Cleanup
To remove all resources created by this project:


Copy code
```bash
terraform destroy```
Alternatively, you can trigger the DESTROY_TERRAFORM parameter in the Jenkins pipeline to automate the cleanup.

Project Structure
graphql
Copy code
cloud-resume-challenge/
├── lambda-functions/
│   └── lambda_function.py       # Lambda function code
├── website/
│   ├── index.html               # Main HTML page
│   ├── resume.css               # Stylesheet
│   ├── counter.js               # JavaScript for visitor counter
│   └── 404.html                 # Custom 404 page
├── modules/                     # Terraform modules (if any)
├── Jenkinsfile                  # Jenkins pipeline configuration
├── main.tf                      # Terraform main configuration
├── variables.tf                 # Terraform variables
├── provider.tf                  # Terraform provider configurations
├── terraform.tfvars             # Terraform variable values
├── README.md                    # Project documentation

