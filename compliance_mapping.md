# compliance_mapping.md
### AWS Honeypot (Cowrie) Security Architecture — Compliance & Control Mapping

This document maps the AWS Honeypot Project’s implemented controls to the relevant security standards.  
Primary frameworks referenced:

- **NIST 800-53 Rev. 5**
- **ISO/IEC 27001:2022**
- **AWS Well-Architected Framework – Security Pillar**

The honeypot is **not a production system** but an isolated research and visibility environment. Compliance mapping demonstrates how its architecture reflects real-world security standards.

---

## 1. NIST 800-53 Control Mapping

| NIST Control | Requirement Summary | Implementation in Honeypot |
|--------------|--------------------|-----------------------------|
| **AC-2: Account Management** | Manage accounts and restrict unnecessary access | IAM role with minimal permissions; no interactive IAM users on EC2 |
| **AC-6: Least Privilege** | Use least privilege for system access | Instance profile grants only CloudWatch + Firehose permissions |
| **AC-17: Remote Access** | Control remote access into systems | Security Group restricts inbound SSH; honeypot traffic isolated |
| **AU-2: Audit Events** | Define events to be logged | Cowrie logging + system logs + CloudWatch Logs enabled |
| **AU-6: Audit Review, Analysis** | Central log aggregation and review | CloudWatch Logs; optional Kinesis → Splunk integration |
| **AU-12: Log Retention** | Ensure retention for investigation | CloudWatch retention policy configurable |
| **CM-2: Baseline Configuration** | Define/maintain baseline configuration | Terraform IaC establishes consistent environment |
| **CM-6: Configuration Settings** | Enforce secure configuration | Hardened EC2 setup + locked-down IAM |
| **CP-9: Backup** | Protect data against loss | Logs stored in CloudWatch; optional S3 archival via Firehose |
| **IR-4: Incident Handling** | Support collection of forensic evidence | Cowrie captures attacker commands, keystrokes, session metadata |
| **SC-7: Boundary Protection** | Control system communication | Dedicated VPC + isolated subnet + restrictive security groups |
| **SC-23: Session Authenticity** | Protect session integrity | Honeypot provides controlled SSH environment |
| **SI-4: System Monitoring** | Detect and monitor malicious events | Attacker behavior captured as system events with CloudWatch |

---

## 2. ISO/IEC 27001:2022 Mapping

| ISO Control | Requirement | Implementation |
|-------------|-------------|----------------|
| **5.15 Access Control** | Restrict access based on roles | IAM least privilege + dedicated instance profile |
| **5.16 Identity Management** | Secure lifecycle of accounts | No IAM users on instance; fully role-based access |
| **5.23 Logging & Monitoring** | Ensure logs are collected and protected | CloudWatch Logs for Cowrie + system logs |
| **5.10 Acceptable Use Controls** | Prevent unnecessary exposure | Isolated VPC with tightly scoped ingress rules |
| **8.12 Change Management** | Control system changes | All changes through Terraform |
| **8.15 Logging** | Implement audit logging | Cowrie + system + CloudWatch logs |
| **8.16 Clock Synchronization** | Maintain consistent timestamps | Amazon Time Sync Service |
| **8.28 Secure Configuration** | Enforce hardened configuration | Terraform, IAM, SG rules establish secure posture |

---

## 3. AWS Well-Architected Framework Mapping

| Pillar | Relevant Practice | Implementation |
|--------|-------------------|----------------|
| **Security** | Identity & access, networking, detective controls | IAM least privilege, isolated VPC, CloudWatch logs |
| **Reliability** | Monitoring / observability | Centralized CloudWatch logging |
| **Operational Excellence** | IaC repeatability | Terraform + structured documentation |
| **Cost Optimization** | Right-sizing + minimal services | t3.micro/t3.small + minimal CloudWatch footprint |

---

## 4. Residual Risks & Governance Notes

| Risk | Description | Mitigation |
|------|-------------|------------|
| **Honeypot as attack pivot** | Attacker may attempt outbound actions | Outbound SG egress restricted; log monitoring |
| **Malicious log content** | Honeypot logs may contain payloads | Review logs in isolated environment |
| **Non-production environment** | Honeypot is intentionally exposed | Separate VPC; no access to production/corporate networks |

---

## 5. Summary

This compliance mapping shows that the AWS Honeypot Project—though intentionally exposed to capture malicious activity—still follows strong controls around identity, logging, network isolation, and auditability. The design aligns with industry-recognized security frameworks, making it suitable as a portfolio artifact for cloud security architecture roles.
