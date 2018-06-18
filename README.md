
A step-by-step guide to create an infrastructure for your company.

## pre-requisites

This is based on the following hyphotesis:
- self hosted nodes (virtual machines) on [digitalocean](http://digitalocean.com/).
- all nodes run docker containers and all services are containers
- containers are managed and orchestrated with [rancher](https://rancher.com/docs/rancher/v1.6/en/).
- the main databases are outsourced to on-premise managed external services.


## nodes

We distinguish nodes between `master`s and `slave`s.

There will be **at least one node as a master** of the infrastructure.
Master duties: 
- holding the rancher server container 
- bastion to access digitalocean and rancher environments for scripting/cron jobs

All other nodes are slaves and have rancher agents running to distribute the load of the services scaling containers.

## use it

Dedicated sections for each step:

1. see the [base setup](docs/base.md) you need
2. create a master/rancher [node](docs/master.md)
3. create a git server [node](docs/gitlab.md) for your company's code
4. work in progress

## to be completed

higher priority:
- [ ] mysql backup in a cronjob into the master volume
- [ ] enable secrets 'service' in each rancher environment

lower priority:
- [ ] separate the ssh bastion from the master/rancher
- [ ] install ansible/terraform on the bastion as a container
- [ ] move the instructions to: 
    + ansible if [this PR](https://github.com/ansible/ansible/pull/33984#issuecomment-392610231) is merged
    + terraform otherwise, see their [docs](https://www.terraform.io/docs/providers/do/index.html)
