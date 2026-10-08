# Security policy

This repository is a credential-free portfolio demonstration.

## Do not commit

- API keys or personal access tokens
- OAuth client secrets or refresh tokens
- n8n credential exports
- Live customer information
- Private Airtable base or table IDs
- Unauthenticated production webhook URLs

## Before enabling the workflows

Use dedicated test accounts, least-privilege credentials and fictional data. Review every outbound recipient before enabling Gmail or WhatsApp nodes.

If you discover a secret in Git history, revoke it immediately before removing it from the repository.

