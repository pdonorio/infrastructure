## Setting up infrastructure with Terraform

#### Prerequsites

To use those templates, you will need the following:

1. Terraform installed, instructions available [here](https://www.terraform.io/intro/getting-started/install.html). 
2. DigitalOcean personal access token, which can be generated [here](https://cloud.digitalocean.com/settings/api/tokens).
3. SSH Key imported to DigitalOcean. There's a possibility to create one using Terraform as well. [Reference](https://www.terraform.io/docs/providers/do/r/ssh_key.html)

#### Description

File `provider.tf` contains a configuration of provider, in our case it's of course DigitalOcean.

In file `variables.tf`, there are all configurable variables use by all other templates.

File `node.tf` contains definitions of droplet, volume and firewall that will be created by executing templates.

#### Using Terraform

0. If that's the first time you're working with this repository, as a first command, run `terraform init`.
1. Provide your DigitalOcean personal access token, so Terraform will be able to act on your behalf. To do so, set the env variable `TF_VAR_do_token` with your token. Terraform can pick up all env variables starting with `TF_VAR_`, so you can configure other options on template in a similar way.
2. Review default variables in `variables.tf`, you can change them either by providing variables in form of `TF_VAR_*` env variables, passing them via `-var` flag with CLI or using `*.tfvars` file. You can review possible options [here](https://www.terraform.io/intro/getting-started/variables.html).
3. After deciding on all variables, you can validate template with `terraform validate` command.
4. To see what resources will be created by Terraform, you can do a 'dry-run' by using `terraform plan` command. This will not create any actual resources yet, but will give you a good picture to review what will happen on your account.
5. To create resources, use the command `terraform apply`. In case you would like to use command line variable subsitution, you can do it e.g. this way: `terraform apply -var 'droplet_ssh_keys[$YOUR_SSH_KEY_ID]'`
