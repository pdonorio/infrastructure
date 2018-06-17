
# rancher

You are going to create at first a rancher node out of a master node.

This node would not require much capacity in resources. The two things used more than average are:

- The database (MySQL). We'll be looking for an [AWS RDS free tier](https://aws.amazon.com/rds/free/).
- The network. Luckily digitalocean has [no bandwith limits](https://www.digitalocean.com/community/questions/how-do-i-check-my-monthly-bandwidth-usage?comment=69760) at the moment.

Let's see what to do now.

## creation

You can use the existing script in this repo, or have a look to do similar operations.

```bash
git clone https://github.com/pdonorio/infrastructure.git
cd infrastructure/nodes/master01
./create.sh

[...]
```

Note: this node should be the first you create. This is why this is the only time the script makes sure you have an ssh public key already set-up within your digitalocean account.

```bash
# to list your current ssh-keys
doctl compute ssh-key list
# to remove the node created
doctl compute droplet delete master01
```

