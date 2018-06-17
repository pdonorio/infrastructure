#!/bin/bash

# Create firewall(s) if not existing
name=$1
port=$2
droplet=$3
ipv4ipv6=",address:0.0.0.0/0,address:::/0"
allports="ports:all" # https://github.com/digitalocean/doctl/issues/247#issuecomment-320989984
allout=",$allports$ipv4ipv6"
icmp="protocol:icmp$ipv4ipv6"
tcpout="protocol:tcp$allout"
udpout="protocol:udp$allout"
outbound="$icmp $tcpout $udpout"
tcprule="protocol:tcp$ipv4ipv6,ports"

# output=$(doctl compute firewall get --no-header $name 2> /dev/null)
output=$(doctl compute firewall list --no-header | grep $name 2> /dev/null)
if [ -z "$output" ]; then
    echo "Firewall rule '$name': creating"
    # --droplet-ids $droplet \
    doctl compute firewall create \
        --name $name \
        --inbound-rules "${tcprule}:$port" \
        --outbound-rules "$outbound"
else
    echo "Firewall rule '$name': existing"
fi

fwid=$(doctl compute firewall list --no-header | grep $name | awk '{print $1}')
echo "Setting up firewall $name: id $fwid"
out=$(doctl compute firewall list-by-droplet $droplet | grep $name 2> /dev/null)
if [ -z "$out" ]; then
    echo "Adding droplet"
    doctl compute firewall add-droplets --droplet-ids $droplet $fwid
fi
