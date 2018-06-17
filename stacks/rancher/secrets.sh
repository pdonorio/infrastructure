#!/bin/bash

###########
# clean existing secrets
for secret in `docker secret ls -q`;
do
    docker secret rm $secret
done

###########
# setup new secrets from .env file
tmpfile="temporary.txt"
for element in `cat .env`;
do
    varname=$(echo $element | cut -d "=" -f 1)
    varvalue=$(echo $element | cut -d "=" -f 2)
    echo $varvalue > $tmpfile
    docker secret create $varname $tmpfile
done
rm -f $tmpfile
