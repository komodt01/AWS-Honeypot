# 🐝 AWS Honeypot Project

This project uses **Terraform** to deploy an **SSH honeypot (Cowrie)** on an AWS EC2 instance. It includes automated **log forwarding to CloudWatch**, and optional **Splunk integration via Kinesis Firehose**. It is ideal for learning cloud security, attacker behavior, and building a hands-on security portfolio.

---

## 🔍 What is a Honeypot?
A **honeypot** is a decoy system designed to attract cyber attackers by simulating vulnerable services or systems. It acts as a trap to detect, analyze, and respond to unauthorized access attempts, giving security teams insight into attacker behavior while protecting critical infrastructure.

### 🔧 How Honeypots Work
1. **Exposure** – The honeypot is intentionally made visible to attackers, mimicking a real system.
2. **Interaction** – Attackers interact with the honeypot, attempting exploits, credential stuffing, or malware deployment.
3. **Logging** – All activity is recorded for analysis.
4. **Analysis & Defense** – Security teams can assess attack patterns, improve defenses, and create threat intelligence from observed behavior.

---

## 🧠 What is Cowrie?
**Cowrie** is a specialized **low-interaction SSH and Telnet honeypot** designed to simulate a real Linux system. It allows defenders to:
- Log unauthorized access attempts
- Record all commands executed by attackers
- Emulate file downloads and fake filesystem interactions
- Analyze attacker tools and tactics safely

Cowrie is a **safer alternative** to high-interaction honeypots, as it does not provide access to a real system but **logs every attacker action** as if they were in a real environment.

---

## 💡 Why Use Kinesis Firehose for Splunk?
**Amazon Kinesis Firehose** is used to forward logs from CloudWatch to **Splunk HEC (HTTP Event Collector)**. Compared to Lambda, it provides:

| Feature                 | Benefit |
|-------------------------|---------|
| **Fully managed**       | No server/code to maintain |
| **Built-in Splunk support** | Native delivery to Splunk HEC |
| **Automatic retries**   | Ensures logs aren’t lost |
| **Batching & buffering**| Reduces API traffic |
| **Backup to S3**        | Failed events stored automatically |

> 🔐 Firehose is ideal for reliable, long-term log streaming to Splunk.

---

## ✅ Prerequisites

### 🔧 Local Setup
```bash
# Install Terraform
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform -y

# Install AWS CLI
sudo apt install awscli -y
aws configure

# Generate SSH key pair for EC2 access
aws ec2 create-key-pair --key-name honeypot-key --query 'KeyMaterial' --output text > honeypot-key.pem
chmod 400 honeypot-key.pem

# Create project directory
mkdir aws-honeypot && cd aws-honeypot
```

---

## 📦 Project Structure
```
aws-honeypot/
├── main.tf                     # Terraform infrastructure (VPC, EC2, IAM)
├── outputs.tf                  # Useful public outputs
├── cowrie-setup.sh             # Bash script to install and start Cowrie
├── cloudwatch-agent-config.json # CloudWatch log forwarding config
├── firehose.tf                 # Kinesis Firehose to Splunk HEC
├── deployment-checklist.md     # Full setup and execution guide
├── linux-commands.md           # All Linux commands used in setup
├── images/
│   └── honeypot-architecture.png # Visual diagram
└── README.md
```

---

## 🐧 Linux Commands
See [`linux-commands.md`](./linux-commands.md) for a complete list of all setup commands used on the EC2 instance.

---

## 🛡️ Final Notes
This project is now complete with:
- EC2-based SSH honeypot
- Centralized CloudWatch logging
- Optional streaming to Splunk HEC
- Fully automated infrastructure with Terraform

You can now shut down, scale up, or archive this repo.

---

## ✨ Credits
- Cowrie: https://github.com/cowrie/cowrie
- Terraform: https://terraform.io
- AWS Free Tier: https://aws.amazon.com/free

---

## 📜 License
MIT License
