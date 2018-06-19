
################
## GitLab URL
external_url 'https://${GITLAB_HOST}'

################
## GitLab PostgreSQL as AWS RDS service
postgresql['enable'] = false

################
## GitLab Redis as outside container
redis['enable'] = false
gitlab_rails['redis_host'] = "redis"
