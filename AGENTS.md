# Repository Guidelines

## Project Structure & Module Organization
The repo separates reusable modules from deployable stacks to keep AWS and GCP concerns clear.
- `envs/<cloud>/<env>/` defines remote-state configs, provider auth, and shared variables.
- `modules/` holds cloud-agnostic building blocks (network, security, compute, data, messaging, observability, dns). Each module exports minimal outputs and enforces tagging.
- `stacks/` assembles modules per workload (`airport-ingestion`, `airport-apis`, `airport-data`) with environment overlays.
- `ci/`, `policies/`, and `scripts/` host automation, OPA rules, and helper tooling; documentation lives under `docs/`.

## Build, Test, and Development Commands
Run `pre-commit install` once. Primary targets live in the Makefile:
- `make lint` ⇒ `terraform fmt`, `tflint`, `tfsec`, `checkov`, `conftest`.
- `make plan ENV=staging STACK=airport-apis` ⇒ remote backend init plus plan preview.
- `make apply` / `make destroy` ⇒ gated applies (non-prod only).
Use `terraform workspace select` inside stacks for additional environment segregation.

## Coding Style & Naming Conventions
- Follow `terraform fmt` (2-space indent, double-quoted strings). Avoid unused variables or locals.
- Resource names follow `{org}-{proj}-{env}-{stack}-{region}` with lowercase and hyphens.
- Prefer modules over inline resources; document deviations in module `README.md`.
- Keep variables typed; provide defaults only when safe across clouds.

## Testing Guidelines
- Lint gates (`tflint`, `tfsec`, `checkov`, `conftest`) must pass before `plan`.
- Add policy fixtures under `policies/tests/`; name files `{service}_{control}.yaml`.
- Store sample var files as `envs/<cloud>/<env>/<stack>.tfvars`; never commit secrets.
- Capture drift or resilience evidence in `docs/resilience/` after each game-day.

## Commit & Pull Request Guidelines
- Use Conventional Commits (`feat:`, `fix:`, `chore:`). Reference tickets or ADR IDs.
- PRs include: summary, stack(s) touched, screenshots of dashboards if applicable, `terraform plan` output, security and cost diffs.
- Request review from security when IAM or policy changes occur; tag ops for runbook updates.

## Security & Compliance Expectations
- Enforce encryption (KMS/CMEK) for every storage module; validate through policies.
- Route public ingress only through WAF/Armor-enabled endpoints; private subnets for data planes.
- Configure OIDC-based CI credentials; forbid long-lived keys in `terraform.tfvars`.
- Track logging and monitoring exports in version control and keep immutable storage copies.

## Agent Workflow Notes
Kick off new work with the Project Architect agent (`codex architect`). Follow with Terraform Scaffolder, then cloud-specific provisioners. Security Reviewer, Resilience Tester, Observability Integrator, and Cost Analyst must sign off before production applies. Keep ADRs and backlog updated whenever architecture or controls evolve.
