## Business Requirements
- Provide a safe, isolated environment to observe attacker behavior against an SSH service.
- Collect detailed telemetry (sessions, commands, IPs) for security analysis and learning.
- Avoid any risk to production systems or customer data.
- Keep monthly spend low enough for personal lab use.

## Architecture Summary
- **Network:** Dedicated VPC + public subnet for the honeypot EC2 instance.
- **Compute:** Ubuntu EC2 instance running Cowrie SSH honeypot.
- **Identity:** IAM role attached via instance profile, granting only required CloudWatch/log permissions.
- **Logging:** CloudWatch Logs for system and Cowrie logs; optional Kinesis Firehose → S3 + Splunk HEC.
- **Management:** Deployed and destroyed via Terraform.

## Design Trade-offs
- **Cost vs. Observability:** Single-AZ, single instance to minimize cost, accepting that availability is lab-level only.
- **Exposure vs. Safety:** Publicly reachable instance to attract attackers, but isolated VPC and restricted IAM to limit blast radius.
- **Simplicity vs. Flexibility:** Terraform-based single environment rather than multiple staged environments, to keep the lab simple.

## Cost Estimate
- EC2 t3.micro or t3.small instance.
- CloudWatch logs ingestion & storage.
- Optional Kinesis Firehose + S3 storage.
> Estimated: low tens of USD/month for continuous running; much less if only run periodically.

## Well-Architected Pillar Mapping
| Pillar | Design Decision | Rationale |
|--------|-----------------|-----------|
| Security | Isolated VPC, least-privilege IAM, central logging | Limit blast radius and preserve forensic data |
| Resilience | Single instance (lab) with easy Terraform redeploy | Lab environment, not production HA |
| Performance | Not performance-critical | Focus is observability, not throughput |
| Cost Optimization | Small instance types, short runtime, minimal ancillary services | Keep lab affordable |
