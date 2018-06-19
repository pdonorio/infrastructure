
# gitlab

work in progress

0. create a gitlab env in rancher
1. create a node
2. create a volume and attach it 
3. add the host to rancher dedicated env
4. add from catalog the secrets rancher service
5. add the secrets needed 
6. add email to domain and setup SMTP
7. build the image with expand_secrets binary
8. add redis to the stack
9. deploy


## instructions

```bash
# access the node via ssh
doctl compute ssh slave01

# remove the welcoming message
rm -rf /etc/update-motd.d/99-one-click
# disable containers firewall, we will use the outside firewall instead
ufw disable
# create a developer user
export MYUSER=developer
useradd -m -d /home/$MYUSER \
    -s /bin/bash -p ! $MYUSER \
    && usermod -aG docker $MYUSER \
    && su - $MYUSER

# prepare the code
git clone https://github.com/pdonorio/infrastructure.git
cd infrastructure/stacks/gitlab

# fix the current variables
vi .env

docker-compose -f build.yml build

```
