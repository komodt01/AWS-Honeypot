# design_overview.md
### AWS Honeypot (Cowrie) — Design Overview

The goal of this project is to deploy a safe, isolated AWS environment that captures attacker behavior while ensuring the surrounding cloud environment remains protected.

---

## 1. Business Purpose

This honeypot supports:

- Threat research  
- Incident response enrichment  
- Training for cloud security analysis  
- Understanding attacker behavior in a controlled environment  

It is not a production system and is intentionally exposed.

---

## 2. High-Level Architecture Summary

Components:

- **VPC (Isolated Subnet)**  
  - Dedicated environment  
  - No connectivity to production or other VPCs  

- **EC2 Honeypot Instance (Cowrie)**  
  - Simulates vulnerable SSH environment  
  - Captures session logs, attacker commands, file uploads  

- **IAM Role + Instance Profile**  
  - Grants only CloudWatch Logs write access  
  - No long-lived credentials  

- **CloudWatch Logs**  
  - Centralized storage for Cowrie + system logs  
  - Immutable, timestamped, tamper-resistant  

- **Optional: Kinesis Firehose → S3 / Splunk**  
  - For enterprise SIEM integration  

- **Analyst Workstation**  
  - Used to review logs and events  
  - Not directly connected to the instance  

---

## 3. Design Principles

- **Isolation:** The honeypot must not reach any internal or production systems.  
- **Containment:** Outbound egress is restricted.  
- **Visibility:** Logging is enabled and centrally stored.  
- **Repeatability:** Terraform manages deployment and teardown.  
- **Safety:** No real data or sensitive keys stored on instance.

---

## 4. Design Trade-Offs

| Decision | Benefit | Trade-Off |
|---------|---------|-----------|
| Single AZ, single instance | Low cost, simple | No resilience; acceptable for honeypots |
| Public SSH exposure | Captures real attacks | Increases noise / frequent scans |
| Outbound restrictions | Prevents pivot attacks | Limits ability to capture attacker outbound behavior |
| Terraform-based IaC | Repeatable, clean teardown | Requires more setup upfront |

---

## 5. Threat Model Overview

Primary threats:

- Unauthorized outbound connections  
- Attempted privilege escalation on the host  
- Malware uploads  
- Automated internet scanning  
- Log tampering attempts  

Mitigations:

- Outbound SG restrictions  
- IAM least privilege  
- Logs stored off-host  

---

## 6. Cost Considerations

Estimated costs (monthly):

- EC2 t3.micro/t3.small: low  
- CloudWatch Logs ingestion: low to moderate depending on attack volume  
- Optional Firehose / S3 / Splunk: moderate but controllable  

Goal: remain under ~$10–$20/mo depending on attack frequency.

---

## 7. Architecture Diagram

See: **honeypot_architecture.png**  
