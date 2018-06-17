
# rancher

You are going to create at first a rancher node out of a master node.

This node would not require much capacity in resources. The two things used more than average are:

- The database (MySQL). We'll be looking for an [AWS RDS free tier](https://aws.amazon.com/rds/free/).
- The network. Luckily digitalocean has [no bandwith limits](https://www.digitalocean.com/community/questions/how-do-i-check-my-monthly-bandwidth-usage?comment=69760) at the moment.

Let's see what to do now.

## creation

You can use the existing `create.sh` script in this repo, or [have a look](nodes/master01/create.sh) to do similar operations.


```bash
git clone https://github.com/pdonorio/infrastructure.git
cd infrastructure/nodes/master01
vi .env # if you wish to change some parameters see the config file

./create.sh

[...]

# creates ssh key if missing

# creates firewall if missing

# creates volume 

# creates node

[...]
```

Note: this node should be the first you create. This is why this is the only time the script makes sure you have an ssh public key already set-up within your digitalocean account.

Extra commands you can use after:

```bash
# to list your current ssh-keys
doctl compute ssh-key list
# to remove the node created
doctl compute droplet delete master01
```

## rancher stack

Swarm mode
(to be completed)

```bash
# access the node via ssh
doctl compute ssh master01

# remove the welcoming message
rm -rf /etc/update-motd.d/99-one-click

# enable swarm mode
myip=$(ifconfig eth0 | awk '{print $2}' | egrep -o '([0-9]+\.){3}[0-9]+')
docker swarm init --advertise-addr $myip

# disable containers firewall, we will use the outside firewall instead
ufw disable

# create a developer user
export MYUSER=developer
useradd -m -d /home/$MYUSER \
    -s /bin/bash -p ! $MYUSER \
    && usermod -aG docker $MYUSER \
    && su - $MYUSER

# deploy the stack
git clone https://github.com/pdonorio/infrastructure.git
cd infrastructure/stacks/rancher
vi .env # if you wish to change some parameters see the config file

# TODO: to be completed

```


## bastion

This node will be used to access digitalocean and rancher accounts for cronjobs and scripts.
