#!/bin/bash
set -e

###############
## SECRETS
echo "Setting secrets"
export GITLAB_DATABASE_HOST="{{DOCKER-SECRET:GITLAB_DATABASE_HOST}}"
export GITLAB_DATABASE_USERNAME="{{DOCKER-SECRET:GITLAB_DATABASE_USERNAME}}"
export GITLAB_DATABASE_PASSWORD="{{DOCKER-SECRET:GITLAB_DATABASE_PASSWORD}}"
source expand_secrets
echo "Connecting to: $GITLAB_DATABASE_HOST"
sleep 5

###############
## GITLAB CONFIG FILE
# NOTE: following the list of variables http://j.mp/2tjKh3v it just
# doesn't work. I had to create the .rb file in etc to convince gitlab
# in using the external database
file="/etc/gitlab/gitlab.rb"
cp /templates/gitlab.rb $file
echo "gitlab_rails['redis_host'] = '$REDIS_HOST'" >> $file
echo "" >> $file
echo "################" >> $file
echo "gitlab_rails['db_adapter'] = '$GITLAB_DATABASE_ADAPTER'" >> $file
echo "gitlab_rails['db_encoding'] = '$GITLAB_DATABASE_ENCODING'" >> $file
echo "gitlab_rails['db_host'] = '$GITLAB_DATABASE_HOST'" >> $file
echo "gitlab_rails['db_port'] = '$GITLAB_DATABASE_PORT'" >> $file
echo "gitlab_rails['db_database'] = '$GITLAB_DATABASE_DATABASE'" >> $file
echo "gitlab_rails['db_username'] = '$GITLAB_DATABASE_USERNAME'" >> $file
echo "gitlab_rails['db_password'] = '$GITLAB_DATABASE_PASSWORD'" >> $file
echo "" >> $file
echo "################" >> $file

## https://docs.gitlab.com/omnibus/settings/smtp.html
echo "gitlab_rails['smtp_enable'] = true" >> $file
echo "gitlab_rails['smtp_domain'] = '$GITLAB_SMTP_DOMAIN'" >> $file
echo "gitlab_rails['smtp_address'] = '$GITLAB_SMTP_ADDRESS'" >> $file
echo "gitlab_rails['smtp_port'] = $GITLAB_SMTP_PORT" >> $file
echo "gitlab_rails['smtp_user_name'] = '$GITLAB_SMTP_USER_NAME'" >> $file
echo "gitlab_rails['smtp_password'] = '$GITLAB_SMTP_USER_PASSWORD'" >> $file
echo "gitlab_rails['gitlab_email_from'] = '$GITLAB_EMAIL_FROM'" >> $file
echo "gitlab_rails['gitlab_email_reply_to'] = '$GITLAB_EMAIL_REPLY_TO'" >> $file
# echo "gitlab_rails['smtp_authentication'] = 'login'" >> $file
# echo "gitlab_rails['smtp_enable_starttls_auto'] = true" >> $file
# echo "gitlab_rails['smtp_openssl_verify_mode'] = 'peer'" >> $file

chmod 400 $file
more /etc/gitlab/*.rb
sleep 5

###############
## GITLAB INIT
/assets/wrapper
