# docker-infra

## Overview

`docker-infra` is an Ansible-based infrastructure automation repository designed to manage and configure a hybrid Docker infrastructure spanning on-premises and cloud hosts. It automates system preparation, monitoring setup, user configuration, container management via Portainer, and runner setup for CI/CD tasks.

The repository leverages Ansible playbooks and roles to ensure consistent and repeatable infrastructure deployment and management. It also integrates with GitHub Actions for continuous integration and automated infrastructure updates.

## Prerequisites

- Ansible (tested with Ansible 2.9+)
- SSH access to target hosts with appropriate private key (`~/.ssh/Perso_SSH`)
- `git-secret` for managing encrypted secrets in the repository
- GPG setup for decrypting secrets
- Access to the Ansible Vault password file (`vault_pass.secret`)

## Repository Structure

- `ansible/` - Contains Ansible playbooks, inventory, roles, and variable definitions
  - `playbook.yml` - Main playbook to install and configure infrastructure components
  - `inventory.ini` - Inventory file defining host groups and hosts
  - `roles/` - Ansible roles for modular configuration:
    - `system-prep` - System preparation tasks (package installation, locales, Docker setup)
    - `monitoring` - Setup of monitoring agents and exporters
    - `user_conf` - User account and configuration management
    - `portainer` and `portainer_stack` - Portainer installation and stack deployment
    - `runner` - Runner setup for CI/CD pipelines
    - `iptables` (currently disabled) - Firewall configuration
- `.github/workflows/` - GitHub Actions workflows for CI/CD automation
- `vault_pass.secret` - Ansible Vault password file (not committed, must be provided)
- `ansible/group_vars/` and `ansible/host_vars/` - Variable files for groups and hosts
- Secret files managed via `git-secret` and decrypted during CI runs

## Inventory and Host Groups

The inventory defines multiple host groups representing different environments and roles:

- `onprem` - On-premises hosts (includes `Homeserver` and `VMs`)
- `cloud` - Cloud hosts (includes `VPS` and `Mail`)
- `infra` - All infrastructure hosts (combines `onprem` and `cloud`)
- Specialized groups for service roles:
  - `Portainer` - Hosts running Portainer container management
  - `Runners` - Hosts configured as CI/CD runners

Each host is defined with its SSH connection details in `ansible/inventory.ini`.

## Usage

### Running Ansible Playbook Locally

Ensure you have access to the SSH keys and Vault password file. Then run:

```bash
ansible-playbook -i ansible/inventory.ini --vault-password-file ansible/vault_pass.secret ansible/playbook.yml
```

You can limit execution to specific hosts or tags as needed.

### GitHub Actions Automation

The repository includes a GitHub Actions workflow (`.github/workflows/update-infra.yml`) that runs on pushes and pull requests to the `main` branch. It performs the following:

- Checks out the repository
- Decrypts secrets using `git-secret` with GPG passphrase from GitHub Secrets
- Runs the Ansible playbook to update infrastructure

This enables automated and secure infrastructure updates via CI/CD.

## Secrets Management

Secrets are managed using `git-secret` and encrypted in the repository. The workflow decrypts these secrets during CI runs. Locally, you must have the appropriate GPG keys and run `git secret reveal` to access secrets.

## Contributing

Contributions are welcome. Please follow these guidelines:

- Use Ansible roles and tags to organize changes
- Test playbooks on a staging environment before production
- Keep secrets out of commits; use `git-secret` for sensitive data
- Follow existing code style and conventions

---

This README provides a comprehensive overview of the `docker-infra` repository, its purpose, usage, and structure to help users and contributors understand and work with the infrastructure automation setup.
