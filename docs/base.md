
# what is needed

Before going further make sure you:

- have an account with some (hopefully free `;)` ) credit on digitalocean
- downloaded and configured [`doctl`]() to access your account
- you have a look at lists of possibilities available in digitalocean:

```bash

# list regions and availability for your nodes
doctl compute region list
# list all existing base images for your nodes
doctl compute image list-distribution
# list sizes
doctl compute size list # check Price Monthly, second-last column

```
