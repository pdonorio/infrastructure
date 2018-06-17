#!/bin/bash

KEY_NAME="mykey"
KEY_PATH="$HOME/.ssh/id_rsa"

#######################
# create the ssh key
if [ -f "$KEY_PATH" ]; then
    echo "Key $KEY_PATH found"
else
    # create ssh key if missing
    echo "Created $KEY_PATH"
    ssh-keygen -f $KEY_PATH -N ''
fi

#######################
# check if there is at least one key in digitalocean
keys_out=$(doctl compute ssh-key list --no-header)
keys_num=$(echo $keys_out | wc -l | tr -d ' ')
# echo "Keys available: $keys_num"
if [ "$keys_num" == "0" ]; then
    echo "importing your main key"
    doctl compute ssh-key import \
        $KEY_NAME \
        --public-key-file $KEY_PATH.pub
else
    echo "key already imported"
fi

#######################
tmp=`echo $keys_out | head -n 1 | awk '{ print $1 }'`
export DO_SSH_KEY=$tmp
