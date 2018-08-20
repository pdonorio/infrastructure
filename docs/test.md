
## rapydo node

NOTE: from ubuntu LTS 18.04

```bash
NODENAME='mynode'

doctl compute droplet create \
    --region nyc3 --ssh-keys 21501958 \
    --size s-1vcpu-2gb --image 34629387 \
    $NODENAME
doctl compute ssh $NODENAME

# setup
rm -rf /etc/update-motd.d/99-one-click
ufw disable
apt-get update && apt-get install -y python3-pip
curl -fsSL get.docker.com -o get-docker.sh && sh get-docker.sh

# create a developer user
export MYUSER=developer
useradd -m -d /home/$MYUSER \
    -s /bin/bash -p ! $MYUSER \
    && yes proofmedia | passwd $MYUSER \
    && usermod -aG docker,sudo $MYUSER \
    && su - $MYUSER

ssh-keygen -t rsa
# copy the key to gitlab

# do use rapydo
git clone ssh://git@git.proofmedia.io:2222/apps/the-game.git game
cd game
sudo -H pip3 install --upgrade -r requirements.txt

# ssh key
cd
mkdir -p .ssh
chmod 700 .ssh
vi .ssh/authorized_keys
```
