#!/bin/bash

source ./.env

out=$(doctl compute droplet list | grep $DO_NODE_NAME)
if [ -z "$out" ]; then
    # Create node
    echo "Creating your node"
    doctl compute droplet \
        create \
        --region $DO_NODE_REGION \
        --ssh-keys $DO_SSH_KEY \
        --size $DO_NODE_SIZE \
        --image $DO_NODE_IMAGE \
        $DO_NODE_NAME
else
    echo "Node existing"
fi
