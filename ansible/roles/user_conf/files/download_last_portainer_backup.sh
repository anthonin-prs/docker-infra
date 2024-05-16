#!/bin/bash

last_backup=$(aws s3 ls vps-pportainer-backups | sort --reverse | grep .tar | head -1 | awk '{ print $4 }')

aws s3 cp s3://vps-portainer-backups/$last_backup .