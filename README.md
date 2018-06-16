
# my self-hosted infrastructure

A step-by-step guide to create an infrastructure for your company, based on the following hyphotesis:

1. Self hosted nodes (virtual machines) on [digitalocean]().
2. All nodes run docker containers and all services are containers
3. Containers are managed and orchestrated with [rancher]().
4. The main databases are outsourced to on-premise managed external services.


## nodes

We distinguish nodes between `master`s and `slave`s.

There will be **at least one node as a master** of the infrastructure.
Master duties: 
- holding the rancher server container 
- bastion to access digitalocean and rancher environments for scripting/cron jobs

All other nodes are slaves and have rancher agents running to distribute the load of the services scaling containers.

## creation

List of nodes to be created:

- master/rancher [node](docs/master.md)
- gitlab server [node](docs/gitlab.md)
- ...

