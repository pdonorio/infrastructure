#!/bin/bash
set -e

export GITLAB_DATABASE_HOST="{{DOCKER-SECRET:GITLAB_DATABASE_HOST}}"
export GITLAB_DATABASE_USERNAME="{{DOCKER-SECRET:GITLAB_DATABASE_USERNAME}}"
export GITLAB_DATABASE_PASSWORD="{{DOCKER-SECRET:GITLAB_DATABASE_PASSWORD}}"

source expand_secrets

/assets/wrapper
