
# gitlab

work in progress

0. create a gitlab env in rancher
1. create a node
2. create a volume and attach it 
3. add the host to rancher dedicated env
4. add from catalog the secrets rancher service
5. add the secrets needed 
GITLAB_DATABASE_USERNAME
GITLAB_DATABASE_PASSWORD
GITLAB_DATABASE_HOST
docker exec -it $(docker ps | grep storage-secrets | awk '{print $1}') bash
rancher-secrets
6. add email to domain and setup SMTP
7. build the image with expand_secrets binary
8. add redis to the stack
9. deploy

