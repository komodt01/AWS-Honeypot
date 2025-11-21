## 1. Security Objectives
- Capture attacker activity in a controlled environment without exposing production assets.
- Maintain confidentiality and integrity of AWS account and logs.
- Ensure availability of logging and monitoring for forensic analysis.
- Provide auditable traces of attacker interactions (IAM, network, and system logs).

## 2. Controls Implemented
- **Identity & Access**
  - Dedicated IAM role for the EC2 honeypot with least-privilege permissions.
  - No long-lived access keys on the instance; use instance profile only.
- **Network Security**
  - Isolated VPC and subnet dedicated to the honeypot.
  - Security group exposing only SSH (and only as needed for the scenario).
- **Logging & Monitoring**
  - CloudWatch agent shipping Cowrie logs to CloudWatch Logs.
  - Optional Kinesis Firehose → Splunk HEC stream for central SIEM ingestion.
- **Governance**
  - All resources deployed through Terraform IaC for repeatability and review.

## 3. Residual Risks & Mitigations
- **Risk:** Honeypot infrastructure could be abused to attack other systems.
  - **Mitigation:** Strict outbound rules; monitor egress; tear down when not in use.
- **Risk:** Logs may contain malicious payloads.
  - **Mitigation:** Treat logs as untrusted input; analyze in isolated tools/VMs.
