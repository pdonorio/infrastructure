#!/bin/bash
set -e

##############
out=$(pwd)
echo "Working dir: $out"
echo

##############
source ./sshkey.sh

##############
source ./.env
# echo "Variables:"
# echo "Region: $DO_NODE_REGION"
# echo "Image: $DO_NODE_IMAGE"
# echo "Size: $DO_NODE_SIZE"
# echo "Key: $DO_SSH_KEY"

if [ -z "$DO_NODE_REGION" ]; then
    echo "Please review and source the '.env' file"
    exit 1
fi

##############
bash node.sh
id=`doctl compute droplet list | grep $DO_NODE_NAME | awk '{print $1}'`
echo "Droplet id: $id"

##############
#  firewall
bash firewall.sh $DO_FW_SSH_NAME $DO_FW_SSH_PORTS $id "in"
bash firewall.sh $DO_FW_WEB_NAME $DO_FW_WEB_PORTS $id "in"

##############
# volume
bash volume.sh $id

# ##############
# echo "To verify the status:"
# echo "doctl compute droplet list"

##############
echo
echo "Completed!"

