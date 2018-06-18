
### populate some secrets

```bash
echo "myfirstsecret" | docker secret create test1 -
echo "myfirstsecret" | docker secret create test2 -
```

### run test stack and install stuff

Write a `tmp.yml` file:

```yaml
version: '3.3'
secrets:
  test1:
    external: true
  test2:
    external: true
services:
  testing:
    image: alpine
    command: sleep 1234567890
    secrets:
      - test1
      - test2
```

And run:
```bash
# create the stack
docker stack deploy -c tmp.yml secrets
# open the bash inside
docker exec -it $(docker ps | grep secrets_testing | awk '{print $1}') ash
# install utils
cd /usr/local/bin/
wget -O confd http://bit.ly/confd_linux_016
wget -O expand_secrets http://bit.ly/secrets_expand_script
chmod +x *
# check with $ confd -h
# check with $ source expand_script
cd

```

### prepare confd

Define template and keys with your configuration

```bash
mkdir -p /etc/confd/conf.d
vi /etc/confd/conf.d/example-configuration.toml
```

with this content

```ini
[template]
src = "example-configuration.conf.tmpl"
dest = "/tmp/example-configuration.conf"
keys = [
    "/test1",
    "/test2",
]
```

Define the configuration variables

```bash
mkdir -p /etc/confd/templates
vi /etc/confd/templates/example-configuration.conf.tmpl
```

with this content:

```
[myconfig]
env_value1 = {{getv "/test1"}}
env_value2 = {{getv "/test2"}}
```


### test everything

```bash
# variables used by confd have to be uppercase
export TEST1="{{DOCKER-SECRET:test1}}"
export TEST2="{{DOCKER-SECRET:test2}}"
# load from secrets
source expand_secrets
# use in config
confd -onetime -backend env
```

And then check the file:
`/tmp/example-configuration.conf`
