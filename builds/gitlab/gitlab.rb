
################
## to be set later on
# external_url 'https://${GITLAB_HOST}'
# gitlab_rails['redis_host'] = "redis"

################
## GitLab PostgreSQL as AWS RDS service
postgresql['enable'] = false

################
## GitLab Redis as outside container
redis['enable'] = false

### SSH ###

gitlab_rails['gitlab_shell_ssh_port'] = 2222


