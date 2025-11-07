# CI Scaffolding

`ci/pipelines/github-actions.yml` contains a starter workflow that validates Terraform stacks for the `dev` environment. Extend the matrix as stacks mature, wire OIDC credentials for AWS and GCP, and add manual approvals for apply jobs.

Generated reports should be written under `ci/reports/` (security, cost) so they can be archived as build artifacts.
