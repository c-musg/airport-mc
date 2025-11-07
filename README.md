# Airport Logistics Terraform Scaffolding

This repository contains Terraform scaffolding for the regional airport logistics platform described in `docs/architecture.md`. Modules under `modules/` model reusable building blocks per cloud, while `stacks/` compose those modules for ingestion, APIs, data, security, and observability domains.

## Getting Started

1. Install Terraform >= 1.6 and the tooling listed in `AGENTS.md` (tflint, tfsec, checkov, conftest, infracost, pre-commit).
2. Choose a stack and environment, then run the Makefile target:
   ```bash
   make plan TF_STACK=stacks/airport-ingestion/aws TF_ENV=dev
   ```
   Backend configuration and variable files are looked up under `envs/<cloud>/<env>/`.
3. Update the environment-specific `backend.hcl` file with the remote state bucket/table before the first `init`.
4. Populate the module input variables in the corresponding `*.tfvars` file for your environment.

## Repository Layout

- `modules/`: Reusable Terraform modules partitioned by domain (network, security, compute, data, observability, dns).
- `stacks/`: Deployable compositions for AWS and GCP resources per workload domain.
- `envs/`: Sample backend configs and `*.tfvars` files for `dev`, `staging`, and `prod` cost profiles.
- `ci/`: Pipeline scaffolding and report directories.
- `policies/`: OPA/Conftest policies that enforce guardrails (sample cost profile policy included).
- `docs/`: Architecture and backlog documentation from the Project Architect.

Extend the modules and stacks as implementation progresses, and keep policy and CI artifacts in sync with new resources.
