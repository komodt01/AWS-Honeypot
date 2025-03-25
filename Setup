🔐 Phase 1: Prerequisites (Manual Setup)
Perform once on your local system and AWS account

1. IAM User / Role Permissions
Make sure your IAM user or assumed role has this policy:
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
2. Install Required Tools
Install Terraform and AWS CLI:
# Terraform
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform -y

# AWS CLI
sudo apt install awscli -y
aws configure

3. Create SSH Key Pair (if not done already)
aws ec2 create-key-pair --key-name honeypot-key --query 'KeyMaterial' --output text > honeypot-key.pem
chmod 400 honeypot-key.pem

4. Create Local Project Directory
mkdir aws-honeypot && cd aws-honeypot
