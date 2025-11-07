# Initial Architecture Backlog

**Legend**  
Priority: P0 (urgent), P1 (near-term), P2 (follow-up)  
Status: Ready, In Progress, Blocked, Done  
Owners map to agents in `AGENTS.md`.

## P0 – Foundation & Security

| ID | Title | Owner | Priority | Status | Definition of Done |
|----|-------|-------|----------|--------|--------------------|
| ARC-001 | Stand up remote Terraform state backends | Terraform Scaffolder | P0 | Ready | Encrypted S3 + DynamoDB table (AWS) and CMEK-backed GCS bucket (GCP) defined and documented |
| ARC-002 | Author KMS/CMEK key hierarchy and IAM boundaries | AWS Provisioner / GCP Provisioner | P0 | Ready | Terraform modules create keys with rotation, aliases per service, IAM scoped to workloads |
| ARC-003 | Configure CI OIDC trust relationships | CI/CD Conductor | P0 | Ready | AWS IAM identity provider + roles and GCP Workload Identity pool configured; usage documented |
| ARC-004 | Seed policy-as-code baselines | Security Reviewer | P0 | Ready | Conftest policies for encryption, networking, cost-profile guardrails; linting configs committed |
| ARC-005 | Publish architecture & backlog | Project Architect | P0 | In Progress | `docs/architecture.md` and `docs/backlog.md` reviewed and approved |

## P1 – Platform Build-Out

| ID | Title | Owner | Priority | Status | Definition of Done |
|----|-------|-------|----------|--------|--------------------|
| ARC-101 | Scaffold core Terraform modules & stacks | Terraform Scaffolder | P1 | Ready | Modules for network, security, compute, data, observability created with variables & examples |
| ARC-102 | Implement AWS networking baseline | AWS Provisioner | P1 | Ready | VPC, subnets, endpoints, optional NAT (feature flag), security groups, flow logs |
| ARC-103 | Implement GCP networking baseline | GCP Provisioner | P1 | Ready | VPC, subnets, firewall rules, Private Service Connect, flow logs |
| ARC-104 | Build messaging pipelines (SNS/SQS, Pub/Sub) | AWS & GCP Provisioners | P1 | Ready | Queues/topics, DLQs, IAM policies, cross-cloud bridge pattern documented |
| ARC-105 | Implement serverless ingestion services | AWS & GCP Provisioners | P1 | Ready | Lambda functions + Cloud Run services with sample handlers; feature flags respected |
| ARC-106 | Provision storage tiers with lifecycle policies | AWS & GCP Provisioners | P1 | Ready | S3/GCS buckets versioned, encrypted, lifecycle policies aligned to cost profile |

## P1 – Governance & Observability

| ID | Title | Owner | Priority | Status | Definition of Done |
|----|-------|-------|----------|--------|--------------------|
| ARC-121 | Wire CI pipeline (lint → policy → plan → cost) | CI/CD Conductor | P1 | Ready | Pipeline definitions committed; dev stack plan succeeds; approvals required for apply |
| ARC-122 | Integrate Infracost & budget alerts | Cost & Efficiency Analyst | P1 | Ready | Infracost runs in CI; thresholds defined; alerts to Slack/Email |
| ARC-123 | Establish observability foundation | Observability Integrator | P1 | Ready | Log sinks, metrics, traces, synthetic checks defined per environment |

## P2 – Resilience, Analytics, Documentation

| ID | Title | Owner | Priority | Status | Definition of Done |
|----|-------|-------|----------|--------|--------------------|
| ARC-201 | Implement cross-cloud DNS failover | AWS Provisioner / GCP Provisioner | P2 | Ready | Route53 + Cloud DNS configured with health checks and weighted policies |
| ARC-202 | Enable data replication pipelines | AWS & GCP Provisioners | P2 | Ready | DataSync / Storage Transfer jobs scheduled; replication monitored |
| ARC-203 | Define resilience game-day playbooks | Resilience & Chaos Tester | P2 | Ready | Runbooks covering outages, latency spikes, queue backlog with success criteria |
| ARC-204 | Expand analytics workloads (BigQuery/Athena) | Data/Analytics Teams | P2 | Ready | Optional analytics modules gated by `enable_analytics`; sample queries documented |
| ARC-205 | Publish operator runbooks & ADRs | Documentation & Readiness Writer | P2 | Ready | Runbooks for apply, failover, incident response; ADRs capturing major decisions |
