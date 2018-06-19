
# gitlab

## temporary list of steps

0. create a gitlab env in rancher
1. create a node and label with 'service=gitlab'
2. create a volume and attach it 
3. add the host to rancher dedicated env
4. add from catalog the secrets rancher service
5. add the secrets needed 
6. add email to domain and setup SMTP
7. build the image with expand_secrets binary
8. add redis to the stack
9. deploy
10. register, become admin, set invite only in "signup restrictions"


## inside the node

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

# build the image (for now, to be automatically builded in the future)
git clone https://github.com/pdonorio/infrastructure.git
cd infrastructure/stacks/gitlab
docker-compose -f build.yml build

```

## from the bastion

FIXME: move part of these commands into a separated `bastion.md`

```bash

cd /tmp/

cliversion='0.6.10'
url="https://releases.rancher.com/cli/v$cliversion"
wget $url/rancher-linux-amd64-v${cliversion}.tar.gz
tar xvzf rancher*.tar.gz
mv rancher-v$cliversion/rancher /usr/local/bin/

compversion='0.12.5'
url="https://releases.rancher.com/compose/v$compversion"
wget $url/rancher-compose-linux-amd64-v${compversion}.tar.gz
tar xvzf rancher*compose*tar.gz
mv rancher-compose-v$compversion/rancher-compose /usr/local/bin/

chmod +x /usr/local/bin/rancher*
rancher config
# follow the instructions

####################
git clone https://github.com/pdonorio/infrastructure.git
cd infrastructure/stacks/gitlab

# set secrets and envs
vi .env
source .env
vi .secrets
./secrets.sh
rancher stacks create gitlab

```
