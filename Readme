# AWS Honeypot (Cowrie) Project

This project deploys a safe, isolated AWS honeypot using Cowrie on an EC2 instance.  
The goal is to observe attacker behavior while maintaining strict isolation from the rest of the AWS account.

---

## 🎯 Purpose

- Capture brute-force attempts  
- Observe attacker commands and behavior  
- Provide training data for analysis  
- Build a secure, repeatable, isolated AWS environment  

---

## 🏗 Architecture Components

- **VPC (Isolated Subnet)**  
- **EC2 Honeypot (Cowrie)**  
- **IAM Role (Least Privilege)**  
- **CloudWatch Logs**  
- Optional: **Kinesis Firehose → S3 / Splunk**

Diagram:  
![Honeypot Architecture](./honeypot_architecture.png)

---

## 📄 Documentation

- [Design Overview](./design_overview.md)  
- [Security Requirements](./security_requirements.md)  
- [Risks & Mitigations](./risks_and_mitigations.md)  
- [Lessons Learned](./lessonslearned.md)

---

## 🚀 Deployment

Deployed and destroyed using Terraform for clean reproducibility.

---

## ⚠️ Disclaimer

This is an intentionally exposed environment used strictly for research and educational purposes.  
It must never be connected to production systems or internal networks.

