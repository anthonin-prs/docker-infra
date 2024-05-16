#!/bin/bash

last_backup=$(aws s3 ls portainer-backups | sort --reverse | grep .tar | head -1 | awk '{ print $4 }')

aws s3 cp s3://portainer-backups/$last_backup .