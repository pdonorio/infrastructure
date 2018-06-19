#!/bin/bash

###########
# clean existing secrets
for secret in `rancher secrets -q`;
do
    rancher rm $secret
done

###########
# setup new secrets
for element in `cat .secrets`;
do
    varname=$(echo $element | cut -d "=" -f 1)
    varvalue=$(echo $element | cut -d "=" -f 2)
    echo $varvalue | rancher secrets create $varname -
done

###########
# list them
rancher secrets
