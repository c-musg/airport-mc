# Repository Guidelines

## 1) Scenario Summary

**Business context**: A regional airport authority needs a logistics platform to optimize ground operations (baggage & cargo routing, crew scheduling, flight status ingestion) with high availability across clouds. The platform ingests events from airlines and sensors, processes them in near-real time, stores them in durable, encrypted storage, and exposes APIs/portals for airport partners.

**Key qualities**

* **Resilience**: Active/active within each cloud and active/passive cross-cloud.
* **Security**: Zero-trust principles, least-privilege IAM, pervasive encryption, continuous policy checks.
* **Portability**: Cloud-agnostic Terraform modules, clear interfaces, and minimal provider-specific lock-in.
* **Observability**: End-to-end tracing/metrics/logging with cross-cloud views.
* **Compliance**: Guardrails via policy-as-code (OPA/Conftest), static checks (tflint/tfsec/Checkov), and change control.

---

## 2) High-Level Architecture (Conceptual)

```
                  +----------------------+             +----------------------+
                  |       AWS (us-east)  |             |   Google Cloud (us-central)
                  |                      |             |                      |
 Events  -------> |  SNS -> SQS ->       |   <--->     |  Pub/Sub -> Sub      | <-------  Events
 (airlines, IoT)  |  Lambda/Fargate APIs |  DataSync   |  Cloud Run / GKE API |
                  |  API GW (WAF)        |  /Transfer  |  Cloud Endpoints/WAF |
                  |  S3 (versioned, KMS) |  /Storage   |  GCS (versioned, CMEK)|
                  |  Aurora/RDS, Dynamo  |  Mirror     |  Cloud SQL/Spanner   |
                  |  OpenSearch/ES       |             |  BigQuery (analytics) |
                  |  CloudWatch, X-Ray   |             |  Cloud Logging/Trace |
                  +----------+-----------+             +-----------+----------+
                             |                                         |
                             |   Cross-cloud health + failover (DNS)   |
                             +------------- Route53 / Cloud DNS -------+
```

**Notes**

* Workloads are split into **event ingestion**, **API layer**, and **data services** in both clouds.
* **Global DNS** steers traffic; synthetic checks drive failover.
* **Data pipelines** mirror hot/warm stores (near-real-time where possible, batch for bulk).

---

## 3) Repository Layout (proposed)

```
/airport-mc
  ├─ agents.md                      # this file
  ├─ README.md
  ├─ envs/
  │   ├─ aws/                       # account(s)/regions
  │   │   ├─ prod/
  │   │   ├─ staging/
  │   │   └─ shared/
  │   └─ gcp/
  │       ├─ prod/
  │       ├─ staging/
  │       └─ shared/
  ├─ modules/
  │   ├─ network/                   # vpc, subnets, gateways
  │   ├─ security/                  # kms/cmek, iam, WAF/Armor
  │   ├─ compute/                   # ecs fargate/gke, cloud run, lambda
  │   ├─ data/                      # s3/gcs, rds/sql, dynamo/spanner
  │   ├─ messaging/                 # sns/sqs, pubsub, bridges
  │   ├─ observability/             # cloudwatch/logging, xray/trace
  │   └─ dns/                       # route53/cloud dns, health checks
  ├─ stacks/                        # composition per environment
  │   ├─ airport-ingestion/
  │   ├─ airport-apis/
  │   └─ airport-data/
  ├─ ci/                            # pipelines, lint, policy
  ├─ policies/                      # OPA/Conftest, Sentinel (optional)
  ├─ scripts/                       # helper scripts (make, bash)
  └─ docs/
```

---

## 4) Global Conventions & Guardrails

* **Terraform**: >= 1.6; separation of **modules** (reusable) vs **stacks** (deployable compositions).
* **State**: remote backends per cloud (`S3+DynamoDB` for AWS; `GCS` for GCP), with server-side bucket encryption and versioning.
* **Naming**: `{org}-{proj}-{env}-{stack}-{region}`.
* **IAM**: least privilege; break-glass roles; short-lived federated identities (OIDC) for CI; no long-lived keys.
* **Secrets**: HashiCorp Vault (preferred) or AWS Secrets Manager / GCP Secret Manager; never in code or TF vars files.
* **Policy**: `tflint`, `tfsec`, `checkov`, `conftest` must pass before `apply`.
* **Observability**: structured logs, metrics SLOs, traces; synthetic checks for user-journeys.
* **Resilience**: multi-AZ (intra-cloud) + multi-region + cross-cloud failover path validated regularly.

---

## 5) Agents Overview

> **New for PoC/testing**: See **5A) Cost Profiles & Free-Tier Toggles** to keep your trial environment within free or very low-cost tiers. These defaults are safe to run in `dev` and `staging` and are disabled in `prod` by design.

> The agents collaborate. Each agent has a **charter**, **inputs**, **outputs**, **tools**, and **permissions**. Codex will prompt you to select and run agents; they reference this file.

### 5.1 Project Architect (Lead)

* **Charter**: Refine requirements, produce target architecture, break work into stacks/modules with acceptance criteria.
* **Inputs**: Scenario (this doc), NFRs, compliance needs.
* **Outputs**: `docs/architecture.md`, backlog in `docs/backlog.md`, initial stack manifests.
* **Tools**: Markdown, PlantUML (diagrams-as-code), ADR templates.
* **Policies**: Protect architectural decisions with ADR approvals.

### 5.2 Terraform Scaffolder

* **Charter**: Generate module skeletons, stack compositions, remote state backends, and Makefile tasks.
* **Inputs**: Architect’s backlog.
* **Outputs**: `modules/*`, `stacks/*`, `envs/*`, `ci/*` scaffolding.
* **Tools**: Terraform, Terragrunt (optional), pre-commit hooks, `tflint` config.

### 5.3 AWS Provisioner

* **Charter**: Implement AWS stacks (VPC, subnets, NAT, ECS Fargate/Lambda, API Gateway + WAF, S3, RDS/Aurora, DynamoDB, Route53, CloudWatch).
* **Security**: KMS-CMKs; S3 bucket policies; WAF rules; IAM boundary policies; logging enabled everywhere.
* **Resilience**: Multi-AZ, blue/green ECS services, health-based failover, cross-region replication for S3 and Aurora.

### 5.4 GCP Provisioner

* **Charter**: Implement GCP stacks (VPC, subnets, Cloud Run/GKE, Cloud Endpoints/Armor, GCS, Cloud SQL/Spanner, Pub/Sub, Cloud DNS, Logging/Monitoring/Trace).
* **Security**: CMEK for supported services; Org policies; least privilege service accounts; VPC SC (optional advanced); Audit logs.
* **Resilience**: Multi-region Cloud Run, GCS bucket versioning, cross-region/dual-region storage, failover health checks.

### 5.5 Security Reviewer (Policy-as-Code)

* **Charter**: Enforce security controls via static analysis and OPA policies prior to apply.
* **Checks**: Encryption at rest in all storages; public exposure only via WAF/Armor; no open security groups; logging required; IAM minimality.
* **Outputs**: Policy reports in `ci/reports/`, PR comments with remediation.

### 5.6 Resilience & Chaos Tester

* **Charter**: Define and run failure game-days; inject faults; verify RTO/RPO and automated DNS failover.
* **Scenarios**: Region loss; service degradation; message backlog; credential rotation.
* **Outputs**: Runbooks in `docs/runbooks/`, evidence in `docs/resilience/`.

### 5.7 Observability Integrator

* **Charter**: Unified dashboards and alerts; cross-cloud SLOs; synthetic transactions.
* **Outputs**: Terraform for metrics/log sinks, uptime checks, alerting policies; dashboard JSONs.

### 5.8 Cost & Efficiency Analyst

* **Charter**: Provide IaC cost diffs; recommend right-sizing and storage classes.
* **Tools**: Infracost; tagging/labeling policies.
* **Outputs**: `ci/reports/cost/` and PR annotations.

### 5.9 Documentation & Readiness Writer

* **Charter**: Produce operator docs, runbooks, onboarding guides, and ADRs that match what was deployed.

### 5.10 CI/CD Conductor

* **Charter**: Wire PR checks, plan/apply workflows per environment with manual approvals; short-lived credentials via OIDC.
* **Tools**: GitHub Actions / GitLab CI / Jenkins; Atlantis or TF Cloud (optional).

---

## 5A) Cost Profiles & Free-Tier Toggles (PoC Defaults)

**Intent**: Run a functional cross-cloud demo at minimal cost by preferring serverless and free-tier quotas, avoiding managed databases with hourly charges, and disabling expensive analytics by default.

### Cost Profiles

* `dev` (default PoC): **Aggressive cost-saving**. Serverless only, tiny quotas, single region per cloud, no managed DBs, no load balancers unless required.
* `staging`: **Moderate**. Keep serverless; enable limited multi-region and health checks; still avoid expensive DBs.
* `prod`: **Full resilience**. Multi-region + DNS failover, managed DBs, stronger quotas.

### AWS PoC (free/low-cost choices)

* **Compute**: Prefer **Lambda** over ECS/Fargate. (1M reqs + 400k GB-s free monthly.)
* **API**: Use **API Gateway HTTP APIs** (cheaper than REST); enable **AWS WAF** only in `staging`/`prod`.
* **Messaging**: **SQS** (first 1M requests free), **SNS** free tier.
* **Storage**: **S3** with **5 GB free tier** (12 months) + versioning; lifecycle to IA after 30 days (PoC volumes tiny).
* **Database**: Avoid RDS/Aurora in `dev`. Use **DynamoDB on-demand**; leverage free 25 GB + read/write free tier.
* **Observability**: Minimal CloudWatch retention (e.g., 3 days) in `dev`; disable detailed metrics.
* **DNS**: **Route53** hosted zone is ~$0.50/mo + queries — create only one shared dev zone.

### GCP PoC (free/low-cost choices)

* **Compute**: **Cloud Run** (generous free per-month vCPU-s and requests). Use min instances = 0.
* **API**: Cloud Run + Cloud Endpoints **only if needed** (ESP adds cost) — otherwise expose Cloud Run with IAP in staging/prod.
* **Messaging**: **Pub/Sub** (lite usage typically low cost; stay within free ops where possible).
* **Storage**: **GCS** standard with lifecycle to nearline after 30 days; dual-region disabled in `dev`.
* **Database**: Avoid Cloud SQL/Spanner in `dev`. Prefer **Firestore** in Native mode (small free tier) or **SQLite/embedded** in container for demos.
* **Analytics**: **Disable BigQuery** in `dev`. If needed, use **BigQuery Sandbox**.
* **Observability**: Reduce log retention to 3 days in `dev`.

### Terraform Feature Flags (variables)

Add to `variables.tf` (root or per-stack):

```hcl
variable "cost_profile" { type = string  default = "dev" }  # dev|staging|prod
variable "enable_managed_db" { type = bool  default = false }
variable "enable_waf_armor" { type = bool  default = false }
variable "enable_multi_region" { type = bool  default = false }
variable "min_instances" { type = number default = 0 }        # Cloud Run/Fargate equivalents
variable "enable_analytics" { type = bool  default = false }
```

In module code, gate resources with these flags. Example (AWS RDS):

```hcl
resource "aws_db_instance" "main" {
  count = var.enable_managed_db ? 1 : 0
  # ... db config ...
}
```

### Example `*.tfvars` (PoC dev)

`envs/aws/dev.tfvars`

```hcl
cost_profile        = "dev"
enable_managed_db   = false
enable_waf_armor    = false
enable_multi_region = false
min_instances       = 0
enable_analytics    = false
```

`envs/gcp/dev.tfvars`

```hcl
cost_profile        = "dev"
enable_managed_db   = false  # use Firestore or embedded
enable_waf_armor    = false  # Armor only in staging/prod
enable_multi_region = false
min_instances       = 0      # Cloud Run scale-to-zero
enable_analytics    = false  # BigQuery off
```

### Security While Cheap

* Keep **encryption on** everywhere (KMS/CMEK); those are near-free.
* Private networking where possible; in `dev` you may skip dedicated NAT gateways (use instance-level egress via serverless to avoid NAT charges).
* Use **IAP** (GCP) and **Cognito or IAM-auth** (AWS) for limited access without public exposure in `dev`.

### CI Safeguards

* Fail any PR that flips `cost_profile` from `dev` to `prod` without approval.
* Conftest policy: deny creation of RDS/Cloud SQL when `cost_profile=="dev"`.

---

## 6) Cross-Agent Operating Principles

* **Single Source of Truth**: Terraform code and policies in repo; environment config via variables/TF workspaces.
* **Change Control**: PRs required; `plan` must be clean; security & cost checks must pass to merge.
* **Secrets Hygiene**: No plaintext secrets in repo; use secret stores and CI OIDC federation.
* **Repeatability**: Everything is idempotent; destroys are safe in non-prod; prod requires two-person approval.
* **Documentation**: Every decision captured as an ADR; every runbook scoped to a user journey (e.g., “API degraded in AWS”).

---

## 7) Inputs & Variables (starter set)

* `org_id`, `project_id` (GCP); `aws_account_id` (AWS)
* `environment`: `prod|staging|dev`
* `regions`: per cloud (e.g., `us-east-1`, `us-west-2`; `us-central1`, `us-east1`)
* `dns_zone`: global DNS zone name
* `cmek_kms_keys`: per service mappings
* `cidr_blocks`: per VPC/subnet
* `workload_switches`: enable/disable components per environment (e.g., GKE vs Cloud Run, Fargate vs Lambda)

---

## 8) Required Tools & Integrations (local + CI)

* **Terraform** (>= 1.6), **tflint**, **tfsec**, **checkov**, **conftest/OPA**, **infracost**
* **AWS CLI** with SSO or OIDC; **gcloud** CLI with ADC (Application Default Credentials)
* **pre-commit** hooks; **make** (optional)
* **Vault / Secrets Manager** providers configured

---

## 9) Security Controls (non-negotiables)

* Encryption at rest with customer-managed keys where supported (KMS/CMEK)
* MFA/SSO for human access; no static keys in CI; OIDC federation for pipelines
* Private subnets for data planes; public ingress only via WAF/Armor and API gateways
* Flow logs and audit logs enabled; log sinks exported to immutable storage
* Least-privilege IAM roles; deny-all boundaries except for narrowly scoped policies

---

## 10) Resilience Tactics

* Multi-AZ and multi-region deployments per cloud
* **Cross-cloud DNS**: health-checked failover from primary (e.g., AWS) to secondary (GCP) and vice-versa
* **Data**: dual-region buckets; asynchronous replication paths; backup + tested restore runbooks
* **Queues**: decouple producers/consumers; DLQs with retention
* **Chaos**: automated failure injections and measurable SLO verification

---

## 11) Workflows

### 11.1 Bootstrap

1. Create org-level backends (S3+DynamoDB; GCS) with encryption and versioning.
2. Create KMS/CMEK keys with rotation.
3. Configure CI OIDC trust (AWS IAM identity provider; GCP workload identity federation).

### 11.2 Plan → Secure → Apply (per stack)

1. `terraform init` with remote backend
2. Run `tflint`, `tfsec`, `checkov`, `conftest` (must pass)
3. `terraform plan` with `-var-file` per env
4. Human review; cost diff via Infracost
5. `terraform apply` (gated)

### 11.3 Drift / Audit

* Nightly drift detection; weekly policy reports; monthly resilience tests.

---

## 12) Agent Prompts (succinct charters for Codex)

### Project Architect — Prompt

> Design a multi-cloud (AWS+GCP) architecture for the regional airport logistics platform. Produce `docs/architecture.md` with diagrams, NFRs, and a breakdown into Terraform modules and stacks as listed in this file. Emphasize security (least privilege, KMS/CMEK, WAF/Armor), resilience (multi-AZ, multi-region, cross-cloud failover), and observability. Output an initial backlog in `docs/backlog.md` with prioritized tasks.

### Terraform Scaffolder — Prompt

> Generate Terraform module skeletons and stack compositions to match the architect’s backlog. Set up remote state backends (S3+DynamoDB on AWS, GCS on GCP), pre-commit hooks, and CI placeholders. Create `Makefile` targets for `lint`, `plan`, `apply`, `destroy`. Seed variables and example `*.tfvars` for `dev`, `staging`, `prod`.

### AWS Provisioner — Prompt

> Implement AWS stacks: networking (VPC, subnets, IGW/NAT), security (KMS, WAF, IAM boundaries), compute (ECS Fargate services and sample Lambda ingestion), data (S3 with versioning+encryption, Aurora or RDS, DynamoDB), messaging (SNS/SQS), DNS (Route53 with health checks), observability (CloudWatch/X-Ray). Ensure encryption, logs, and least-privilege IAM.

### GCP Provisioner — Prompt

> Implement GCP stacks: networking (VPC, subnets), security (CMEK, IAM, Armor), compute (Cloud Run and sample GKE), data (GCS dual-region with versioning, Cloud SQL/Spanner), messaging (Pub/Sub), DNS (Cloud DNS with health checks), observability (Cloud Logging/Monitoring/Trace). Ensure org policies and audit logging.

### Security Reviewer — Prompt

> Run tflint/tfsec/checkov and OPA/Conftest against the stacks. Fail the run on missing encryption, wide-open ingress/egress, or public resources without WAF/Armor. Produce a remediation report in `ci/reports/security/`.

### Resilience & Chaos Tester — Prompt

> Define and automate failure drills: region outage, API latency spikes, queue backlog. Validate DNS failover. Capture results and RTO/RPO evidence in `docs/resilience/`.

### Observability Integrator — Prompt

> Provision dashboards, uptime checks, SLOs, and alerting policies in both clouds. Export dashboard JSONs and alert policies to version control. Create synthetic user journeys.

### Cost & Efficiency Analyst — Prompt

> Integrate Infracost; annotate PRs with cost diffs. Recommend right-sizing and storage class changes.

### Documentation & Readiness Writer — Prompt

> Generate operator runbooks, onboarding, and change management docs aligned with what is provisioned. Keep docs shallow if code is authoritative; deep dive where human action is required.

### CI/CD Conductor — Prompt

> Create pipelines that execute lint → policy → plan → cost → approval → apply. Use OIDC-based short-lived credentials. Support per-env manual approvals.

---

## 13) Permissions & Secrets (minimum)

* **CI OIDC**: Trust relationships defined in AWS IAM and GCP Workload Identity Federation.
* **Human auth**: SSO/MFA; separate admin vs. read-only roles.
* **Secret stores**: Vault or cloud-native; access scoped to workloads.

---

## 14) Definition of Done (per environment)

* All stacks applied with encryption, logging, and policy checks green
* Synthetic checks passing; SLOs defined and alerting in place
* Resilience drill executed and documented
* Runbooks and ADRs merged
* Cost baseline captured; budget alerts configured

---

## 15) Getting Started (quick)

1. Ensure Node/`codex` works in WSL and you’re in repo root.
2. Run `codex` and select **Project Architect** to generate initial docs/backlog.
3. Then run **Terraform Scaffolder** to create modules/stacks.
4. Use **AWS Provisioner** and **GCP Provisioner** in staging first.
5. Gate everything through **Security Reviewer**, then proceed to prod when satisfied.

> If your local version of `codex` expects a different entry file name or flag, run `codex --help` and adapt (this file is standard markdown; most setups auto-discover `agents.md`).

---

## 16) Anti-Patterns to Avoid

* Copy-pasting cloud-specific code without abstraction boundaries
* Embedding secrets in TF vars or CI envs
* Skipping policy checks due to “speed”
* Single-region thinking in a multi-cloud platform

---

## 17) Next Milestones (suggested)

* [ ] Author `docs/architecture.md` and `docs/backlog.md`
* [ ] Bootstrap remote states and KMS/CMEK
* [ ] Scaffold core network/security modules in both clouds
* [ ] Stand up ingestion and API sample services
* [ ] Wire observability and cost analysis
* [ ] Run first resilience drill and document outcomes
