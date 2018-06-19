#!/bin/bash
set -e

## SECRETS
echo "Setting secrets"
export DB_HOST="{{DOCKER-SECRET:GITLAB_DATABASE_HOST}}"
export DB_USERNAME="{{DOCKER-SECRET:GITLAB_DATABASE_USERNAME}}"
export DB_PASSWORD="{{DOCKER-SECRET:GITLAB_DATABASE_PASSWORD}}"
source expand_secrets
echo "Connecting to: $DB_HOST"
sleep 5

## GITLAB INIT
cp /templates/gitlab.rb /etc/gitlab/
more /etc/gitlab/*.rb
sleep 5
/assets/wrapper
