#!/bin/bash
set -e

##############
echo "Current workind dir:"
pwd
echo

##############
echo "Check ssh key:"
source ./sshkey.sh

##############
source ./.env
echo "Variables:"
echo "Region: $DO_NODE_REGION"
echo "Image: $DO_NODE_IMAGE"
echo "Size: $DO_NODE_SIZE"
echo "Key: $DO_SSH_KEY"

if [ -z "$DO_NODE_REGION" ]; then
    echo "Please review and source the '.env' file"
    exit 1
else
    echo
fi

##############
echo "Creating your node:"
doctl compute droplet \
    create \
    --region $DO_NODE_REGION \
    --ssh-keys $DO_SSH_KEY \
    --size $DO_NODE_SIZE \
    --image $DO_NODE_IMAGE \
    $DO_NODE_NAME
echo

echo "To verify the status:"
echo "doctl compute droplet list"
echo
echo "Completed!"

