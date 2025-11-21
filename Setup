# setup.md
### AWS Honeypot — Setup Guide

This guide provides the one-time prerequisites required to prepare your local environment and AWS account before deploying the honeypot using Terraform.

---

# Phase 1: Prerequisites (One-Time Setup)

These steps must be completed once before running Terraform.

## 1. IAM Permissions Required

The IAM user or role you are using must have permissions to create EC2 instances, VPC networking resources, IAM roles and instance profiles, CloudWatch log groups, and optional SSM commands.

Recommended lab policy:

{
  "Effect": "Allow",
  "Action": [
    "ec2:*",
    "iam:PassRole",
    "iam:CreateRole",
    "iam:AttachRolePolicy",
    "logs:*",
    "cloudwatch:*",
    "vpc:*",
    "ssm:*"
  ],
  "Resource": "*"
}

## 2. Install Required Tools

### Install Terraform
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform -y

### Install AWS CLI
sudo apt install awscli -y
aws configure

(Enter Access Key, Secret Key, Region like us-east-1, and output format)

## 3. Create an SSH Key Pair (If Not Already Created)

aws ec2 create-key-pair --key-name honeypot-key --query "KeyMaterial" --output text > honeypot-key.pem
chmod 400 honeypot-key.pem

## 4. Set Up Local Project Directory

If using GitHub:
git clone https://github.com/<your-username>/aws-honeypot.git
cd aws-honeypot

If working offline:
mkdir aws-honeypot
cd aws-honeypot

---

# Phase 2: Deploy With Terraform

terraform init
terraform plan
terraform apply

Terraform will deploy:
- Isolated VPC
- EC2 Cowrie honeypot
- IAM instance profile
- CloudWatch log groups

---

# Phase 3: Teardown When Finished

terraform destroy

---

# Notes

- This is an intentionally exposed research environment.
- Do not connect this VPC to any production network.
- Logs may contain malicious content; analyze them from a safe workstation.
