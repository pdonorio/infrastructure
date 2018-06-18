
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

## stack

To launch the rancher stack we want to use some outsourced database instead of one simple container with everything inside. This action would ensure easy upgrades of the rancher server and no damage if the containers crashes for any reason. A separated MySQL container would be fine too: but then backups and reliability become an issue.

To configure rancher to use an external servers with relative credentials we want to ensure better-than-average security and avoid making credentials available as environment variables. More on this topic [in this post](https://medium.com/lucjuggery/from-env-variables-to-docker-secrets-bc8802cacdfd).

To use secrets we need the `swarm mode` active on the docker engine.
Also secrets cannot be passed directly to the container (they are files, not variables), so we need to override the rancher container entrypoint to inject the secrets.

Here are the instructions to work all of this out:


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

# prepare the code
git clone https://github.com/pdonorio/infrastructure.git
cd infrastructure/stacks/rancher

# set variables for your outside database
vi .env

# generate the secrets in the swarm from the .env file
./secrets.sh

# launch the stack
docker stack deploy -c docker-compose.yml rancher
# check existence
docker stack ls
docker stack services rancher
# verify the services processed
docker stack ps rancher
# logs
docker logs -f $(docker ps -n 1 -q)

```

### issues

1. I was stuck to this error:
```
QueryException: Table 'cattle.setting' doesn't exist
```
It seems related to slow performances in network or the db instance, see [this comment](https://github.com/rancher/rancher/issues/8962#issuecomment-365288044).

I solved without switching to a more performant size of RDS, but instead moving the db instance to the same region of the DO host.

2. SSL is not yet enabled

It seems you have to [do complex things](https://rancher.com/docs/rancher/v1.6/en/installing-rancher/installing-server/#http-proxy) to use the rancher API, catalog and integration with the registry with SSL on this server. I'm skipping this for now.

## configuring

To be completed.
Steps to be done programmatically via API:

- Create a token
- Switch to github accounting
- Add a list of github accounts
- Create an env for the rancher node 
- Request an host to add and launch the agent command

## bastion

This node will be used to access digitalocean and rancher accounts for cronjobs and scripts.

**TO BE COMPLETED**
