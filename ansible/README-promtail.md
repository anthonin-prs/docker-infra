# Promtail Deployment Playbook

This playbook deploys Promtail to all servers in your infrastructure to collect logs and send them to Loki.

## Prerequisites

- Loki should be running and accessible from all servers
- The `loki_url` variable should be defined in your `group_vars/all.yml` or provided via extra vars

## Usage

To deploy Promtail to all servers:

```bash
ansible-playbook promtail-playbook.yml
```

If the `loki_url` is not defined in your group variables, you can provide it via the command line:

```bash
ansible-playbook promtail-playbook.yml --extra-vars "loki_url=http://loki:3100"
```

## Configuration

The playbook uses the following configuration:

- Promtail version: Defined in `roles/monitoring/vars/main.yml`
- Loki URL: Should be defined in `group_vars/all.yml` or provided via extra vars
- Log sources: Configured in `roles/monitoring/templates/promtail.yaml.j2`

## Logs Collected

By default, Promtail is configured to collect the following logs:

- System logs: `/var/log/syslog`, `/var/log/messages`, `/var/log/auth.log`, `/var/log/user.log`
- Docker container logs: `/var/lib/docker/containers/*/*log`

## Customization

To customize the logs collected, modify the `roles/monitoring/templates/promtail.yaml.j2` template.
