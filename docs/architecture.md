# Airport Logistics Platform – Architecture Blueprint

## 1. Purpose and Scope
- Define the multi-cloud (AWS + GCP) target architecture for airport logistics (baggage, cargo, crew, flight events).
- Guide downstream Terraform modules/stacks, CI/CD, and policy guardrails.
- Capture mandatory security, resilience, observability, and compliance requirements for dev, staging, prod.

## 2. Business Drivers & NFRs
| Category | Objective | Architectural Response |
|----------|-----------|------------------------|
| Resilience | Operate through AZ/region/cloud failures | Active/active intra-cloud, active/passive cross-cloud via DNS health checks, multi-AZ deployments, async mirroring |
| Security | Zero-trust, least privilege, encryption | Federated identities, scoped IAM, KMS/CMEK everywhere, WAF/Armor on ingress, policy-as-code |
| Portability | Avoid lock-in | Terraform modules with clear interfaces, feature toggles, minimal provider specifics |
| Observability | Unified visibility | Cross-cloud logs/metrics/traces, centralized dashboards, synthetic checks |
| Compliance | Enforced controls | tflint/tfsec/checkov/conftest in CI, ADRs, immutable logs, change control |
| Cost Control | Keep PoC spend low | Cost profile flags, serverless-first dev/staging, lifecycle policies, Infracost |

## 3. Solution Overview
- AWS `us-east-1` as primary; GCP `us-central1` secondary plus analytics.
- Domains: event ingestion, API services, data services, shared services (security, observability, CI).
- Data mirrored between clouds (S3⇄GCS, Dynamo⇄Firestore) with encryption and versioning.
- Terraform-managed infrastructure; remote state in encrypted S3/DynamoDB and CMEK-backed GCS.

## 4. Logical Architecture
```plantuml
@startuml
left to right direction
actor Airline
actor "Airport Partner" as Partner
cloud "Global DNS\n(Route53 + Cloud DNS)" as DNS
rectangle "AWS us-east-1" as AWS {
  collections "API Gateway (HTTP) +\nAWS WAF" as APIGW
  queue "SNS Topics" as SNS
  queue "SQS Queues\n(+ DLQ)" as SQS
  frame "Lambda Ingestion\n(Fan-out & ETL)" as Lambda
  rectangle "Lambda / Fargate APIs" as ComputeAWS
  database "DynamoDB\n(on-demand, PITR)" as Dynamo
  folder "S3 Buckets\n(versioned, KMS)" as S3
  database "Aurora Serverless\n(prod only)" as Aurora
  storage "OpenSearch" as ES
  collections "CloudWatch + X-Ray" as CW
}
rectangle "GCP us-central1" as GCP {
  collections "Cloud Load Balancer +\nCloud Armor" as LB
  queue "Pub/Sub Topics\n(+ DLQ)" as PubSub
  rectangle "Cloud Run Services" as CloudRun
  rectangle "GKE (optional)" as GKE
  database "Firestore / Cloud SQL" as SQL
  folder "GCS Buckets\n(versioned, CMEK)" as GCS
  storage "BigQuery Sandbox" as BQ
  collections "Cloud Logging + Trace" as Stackdriver
}
cloud "Data Sync & Replication" as Mirror
Airline --> DNS
Partner --> DNS
DNS --> APIGW
DNS --> LB
SNS --> SQS
SQS --> Lambda
Lambda --> ComputeAWS
ComputeAWS --> {Dynamo, S3, Aurora}
S3 --> Mirror
Mirror --> GCS
PubSub --> CloudRun
CloudRun --> {SQL, GCS, BQ}
AWS --> Stackdriver
GCP --> CW
@enduml
```

## 5. Workload Domains
### 5.1 Event Ingestion
- AWS: SNS→SQS→Lambda for airline/IoT events; writes to DynamoDB/S3; DLQs for reprocessing.
- GCP: Pub/Sub with Cloud Run consumers; Firestore/GCS storage; DLQs mirrored.
- Cross-cloud bridges via DataSync/Transfer Service and managed connectors; dedupe on replay.

### 5.2 API Layer
- AWS API Gateway HTTP + Lambda/Fargate; WAF in staging/prod; Cognito/IAM auth.
- GCP Cloud Run behind Global Load Balancer + Cloud Armor; optional Cloud Endpoints/IAP.
- Global DNS health-checked routing; synthetic journeys validate readiness.

### 5.3 Data Services
- DynamoDB (on-demand dev/staging, provisioned prod) with streams; Aurora Serverless prod only.
- S3/GCS as versioned data lakes with lifecycle to cheaper tiers; encryption via KMS/CMEK.
- Analytics optional per environment (Athena, BigQuery Sandbox); flagged by `enable_analytics`.

### 5.4 Shared & Platform Services
- Identity via AWS IAM Identity Center and GCP IAM federation; Vault preferred for secrets.
- Observability: CloudWatch/X-Ray, Cloud Logging/Trace/Monitoring; OpenTelemetry exporters; shared dashboards.

## 6. Data Flow & Storage Strategy
1. Events land in AWS ingestion stack; normalized, stored in DynamoDB/S3.
2. Near-real-time replication to GCP via DataSync/Transfer, preserving encryption.
3. Batch exports (Glue/Athena ⇄ BigQuery) for analytics when enabled.
4. Crew scheduling updates propagate through SNS/SQS and Pub/Sub to APIs/portals.
5. Daily backups, versioning, and retention policies aligned to compliance.

## 7. Networking & Connectivity
- Dedicated VPCs per environment/cloud; private subnets for workloads, public only for ingress.
- AWS: IGW, optional NAT (disabled in dev), VPC endpoints for AWS services, flow logs to S3.
- GCP: VPC with subnet segmentation, firewall least privilege, Private Service Connect, flow logs to Logging.
- Cross-cloud VPN/Direct Connect + Interconnect (prod); encrypted traffic only.
- Route53 + Cloud DNS share delegated zone; health checks monitor API endpoints and synthetics.

## 8. Security Architecture
- Federated CI OIDC roles; short-lived credentials; break-glass roles tightly audited.
- CMKs/CMEKs per service with rotation; separate keys for storage, databases, messaging.
- WAF/Armor enforce IP/rate/OWASP controls; only enabled when `enable_waf_armor` true.
- Zero-trust: ingress via API gateways/load balancers; mTLS for internal calls; VPC Service Controls optional.
- Policy-as-code: Conftest denies unencrypted resources, public buckets, wide CIDRs, cost profile violations.

## 9. Resilience & Disaster Recovery
- Active/active ingestion and queueing; cross-cloud failover using weighted DNS.
- Multi-AZ deployments; DynamoDB global tables & Aurora global database in prod.
- GCS dual-region buckets for prod; Cloud Run multi-region (`enable_multi_region`).
- Scheduled chaos drills (region loss, queue backlog) with documented RTO/RPO.
- Backup strategy: S3/GCS versioning, DynamoDB PITR, Aurora snapshots replicated across regions.

## 10. Observability & Operations
- Structured JSON logging; export to immutable storage (S3 Glacier/GCS Archive) for compliance.
- Metrics and SLOs for API latency, queue depth, replication lag; unified dashboards.
- Tracing via X-Ray and Cloud Trace; OTEL collectors to central analytics if needed.
- Alerts with multi-channel escalation; synthetic tests simulate baggage updates and crew roster flows.

## 11. Terraform Decomposition
| Concern | Modules (`modules/*`) | Stacks (`stacks/*`) | Notes |
|---------|-----------------------|---------------------|-------|
| Networking | `network/aws`, `network/gcp` | Included per stack | VPC, subnets, routing, endpoints |
| Security | `security/kms`, `security/iam`, `security/waf` | `airport-shared-security` | Keys, IAM roles, WAF/Armor, secrets |
| Messaging | `messaging/sns_sqs`, `messaging/pubsub` | `airport-ingestion` | Queues/topics, DLQs, cross-cloud bridges |
| Compute | `compute/lambda`, `compute/fargate`, `compute/cloud_run`, `compute/gke` | `airport-ingestion`, `airport-apis` | Serverless/container workloads with flags |
| Data | `data/s3`, `data/dynamodb`, `data/aurora`, `data/gcs`, `data/firestore`, `data/bigquery` | `airport-data` | Storage, databases, lifecycle, replication |
| Observability | `observability/cloudwatch`, `observability/gcp` | Shared stack | Metrics, logs, traces, alerts |
| DNS & Failover | `dns/route53`, `dns/cloud_dns`, `dns/healthchecks` | Global stack | Zones, health checks, failover policies |
| Policy | `policies/*` | CI only | Conftest, linting configs |
| CI/CD | `ci/github_actions` (or equivalent) | N/A | Lint→policy→plan→cost→apply workflows |

## 12. Environment Profiles & Feature Flags
| Variable | dev | staging | prod |
|----------|-----|---------|------|
| `cost_profile` | `dev` | `staging` | `prod` |
| `enable_managed_db` | `false` | `true` (limited) | `true` |
| `enable_waf_armor` | `false` | `true` | `true` |
| `enable_multi_region` | `false` | `true` for critical services | `true` |
| `min_instances` | `0` | `1` | `>=2` |
| `enable_analytics` | `false` | `true` (canary) | `true` |
| Observability retention | 3 days | 7 days | 30+ days |
| DNS zones | Shared dev | Pre-prod | Production with failover |

## 13. CI/CD & Governance
1. Pre-commit: `terraform fmt`, `tflint`, `tfsec`, `checkov`, `conftest`, `infracost`.
2. Pipeline stages: lint → policy → plan (remote state) → cost diff → manual approval → apply.
3. Credentials: GitHub/GitLab OIDC to AWS IAM + GCP Workload Identity; no long-lived keys.
4. Change control: ADRs for major decisions; PR template captures risk; prod applies require dual approval.

## 14. Assumptions & Open Questions
- Airline event protocols (HTTPS vs. MQTT) to confirm for ingestion adapters.
- Cross-cloud network (VPN vs. Direct Connect/Interconnect) pending network team decision.
- Vault deployment model (self-managed vs. cloud) awaiting security guidance.
- Data residency requirements for crew info may dictate additional regions.
- Confirm CI platform (assumed GitHub Actions); adjust pipeline modules if different.
- Finalize SLO targets per API and queue to tune observability thresholds.
