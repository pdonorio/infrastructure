
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

## creation

Note: please have a look to the [base setup](docs/base.md) you need to continue testing these documentation.

List of nodes to be created:

- master/rancher [node](docs/master.md)
- gitlab server [node](docs/gitlab.md)
- ...

