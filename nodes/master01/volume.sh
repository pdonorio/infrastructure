#!/bin/bash

droplet_id=$1
source ./.env

id=$(doctl compute volume list | grep $DO_NODE_NAME | awk '{print $1}' 2> /dev/null)
if [ -z "$id" ]; then
    echo "Creating volume"
    doctl compute volume \
        create \
        --size $DO_VOLUME_SIZE \
        --region $DO_NODE_REGION \
        --fs-type $DO_VOLUME_TYPE \
        $DO_NODE_NAME
    sleep 2
    id=$(doctl compute volume list | grep $DO_NODE_NAME | awk '{print $1}')
fi

echo "Volume: $id"

doctl compute volume-action attach \
    $id $droplet_id \
    2> /dev/null
# FIXME: no current way to check if the volume is already attached
# Droplet IDs in doctl compute volume get seems always marked as <nil>
