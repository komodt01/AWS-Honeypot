# Lessons Learned: AWS Honeypot Deployment

## 1️⃣ What Went Well ✅

### **Successfully Deployed a Honeypot in AWS** 🛠️  
- Set up an **isolated VPC & subnet** for security.
- Deployed **Ubuntu EC2 instance** with Cowrie.
- Used **Terraform for automation**.

### **CloudWatch Logging & Monitoring** 📊  
- Forwarded logs from Cowrie → CloudWatch.
- Verified log ingestion & retrieval.

### **IAM Role & Security Improvements** 🔐  
- Created and attached **IAM Role (`HoneypotRole`)**.  
- Verified permissions using **AWS CLI & metadata service**.

---

## 2️⃣ Challenges & How They Were Resolved ⚠️

| **Issue** | **Resolution** |
|-----------|---------------|
| IAM Role **not recognized** by EC2 | Created an **Instance Profile** & attached it. |
| EC2 **couldn’t fetch AWS credentials** | Restarted **metadata service** (`amazon-ssm-agent`). |
| CloudWatch Logs **denied access** | Added `CloudWatchLogsReadOnlyAccess` to IAM Role. |
| Unable to SSH due to **key file permissions** | Fixed with `chmod 400 honeypot-key.pem`. |
| `cowrie.cfg.dist` file **missing** | Verified correct Cowrie installation path. |
| CloudWatch Agent **not found in Ubuntu** | Manually installed using the **AWS package repository**. |

---

## 3️⃣ Key Takeaways 📌

- **IAM Instance Profiles are required for EC2 to assume IAM roles**  
- **AWS metadata service (`169.254.169.254`) is critical for IAM role verification**  
- **CloudWatch permissions must be explicitly granted (`logs:GetLogEvents`)**  
- **Terraform is useful for automating infrastructure setup**  
- **Security groups should be restricted to limit attack surface**  
- **Cowrie logs can provide valuable threat intelligence**  

---

## 4️⃣ Future Improvements & Enhancements 🚀

### 🔐 **Enhance Security**
- Implement **AWS WAF** to filter malicious requests.  
- Restrict **IAM permissions** further using **least privilege**.  
- Rotate AWS credentials and keys regularly.  

### 📊 **Improve Logging & Monitoring**
- Integrate with **Splunk** for deeper log analysis.  
- Use **AWS GuardDuty** to detect suspicious activity.  

### 🤖 **Automate Deployment Fully**
- Use **Terraform to deploy entire stack**, including networking, EC2, IAM, and CloudWatch.  
- Create **Lambda function to auto-respond to threats** (e.g., blocking attacking IPs).  

---

## 🎯 **Final Summary**
🎉 **This AWS honeypot project was a success!**  
✅ **Captured & forwarded attack logs**  
✅ **Configured IAM, networking, and security**  
✅ **Troubleshot & resolved AWS setup challenges**  

This document serves as a reference for future security projects! 🚀🔥  
