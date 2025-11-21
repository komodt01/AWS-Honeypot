# security_requirements.md
### AWS Honeypot Project — Security Requirements

Although a honeypot is intentionally exposed to attacker traffic, the surrounding AWS environment **must remain secure**.  
These requirements define what must be protected even while the honeypot itself is intentionally vulnerable.

---

## 1. Objectives

- Capture attacker behavior (commands, IPs, sessions, techniques).
- Prevent the honeypot from becoming a pivot point into the AWS account.
- Preserve the integrity and availability of logs for analysis.
- Minimize cost and blast radius.
- Ensure the environment can be safely torn down and rebuilt.

---

## 2. Identity & Access Requirements

- **No IAM users** may authenticate to the honeypot instance.
- An **IAM Role + Instance Profile** must be used instead of static credentials.
- IAM permissions must follow **least privilege**, only allowing:
  - CloudWatch Logs write access
  - Optional Kinesis Firehose delivery
- Terraform must manage IAM to ensure repeatability and auditability.

---

## 3. Network & Isolation Requirements

- Honeypot must be deployed in a **dedicated VPC or isolated subnet**.
- Security Group must:
  - Allow inbound SSH (0.0.0.0/0 is acceptable for honeypots)
  - Restrict outbound traffic to prevent lateral movement
- No VPC peering, private links, or routes to production resources.

---

## 4. Logging & Monitoring Requirements

- Cowrie logs must be forwarded to **CloudWatch Logs**.
- System logs (auth, syslog) must also be collected.
- Logs must retain integrity — attackers should not be able to modify CloudWatch entries.
- Optional: Kinesis Firehose → S3 or Splunk for deeper analysis.

---

## 5. Configuration Requirements

- Terraform IaC must deploy:
  - VPC + Subnet
  - EC2 instance
  - IAM role
  - SG rules
  - CloudWatch log group(s)

- EC2 instance must be locked down:
  - No new packages outside Cowrie dependencies
  - No sensitive data or secrets
  - No key material stored on disk

---

## 6. Residual Risks

These risks are **normal for honeypots** and must be acknowledged:

- Attackers may attempt outbound scanning → mitigated by outbound SG restrictions.
- Attackers may upload malware → logs reviewed in separate analyst system.
- IP address will be targeted continuously → expected behavior.

---

## 7. Acceptance Criteria

A honeypot deployment is acceptable when:

- Logs stream to CloudWatch successfully.
- IAM role has no excess permissions.
- SSH is reachable publicly and Cowrie is logging sessions.
- Outbound pivot attempts are blocked.
- Terraform can fully deploy and destroy the environment.

