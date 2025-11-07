# Policy-as-Code Skeleton

This directory holds OPA/Conftest policies that gate Terraform plans before apply. Populate the `cost`, `security`, and `network` subfolders with rules that enforce the guardrails in `AGENTS.md`.

Current coverage:
- `cost/cost_profile.rego`: Blocks managed database resources when `cost_profile` is set to `dev`.

Add additional packages as modules mature (encryption checks, WAF enforcement, IAM least privilege, etc.).
