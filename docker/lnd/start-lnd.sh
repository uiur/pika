#!/usr/bin/env bash

# exit from script if error was raised.
set -ex

# error function is used within a bash function in order to send the error
# message directly to the stderr output and exit.
error() {
    echo "$1" > /dev/stderr
    exit 0
}

# return is used within bash function in order to return the value.
return() {
    echo "$1"
}

# set_default function gives the ability to move the setting of default
# env variable from docker file to the script thereby giving the ability to the
# user override it durin container start.
set_default() {
    # docker initialized env variables with blank string and we can't just
    # use -z flag as usually.
    BLANK_STRING='""'

    VARIABLE="$1"
    DEFAULT="$2"

    if [[ -z "$VARIABLE" || "$VARIABLE" == "$BLANK_STRING" ]]; then

        if [ -z "$DEFAULT" ]; then
            error "You should specify default variable"
        else
            VARIABLE="$DEFAULT"
        fi
    fi

   return "$VARIABLE"
}

# Set default variables if needed.
RPCUSER=$(set_default "$RPCUSER" "devuser")
RPCPASS=$(set_default "$RPCPASS" "devpass")
DEBUG=$(set_default "$DEBUG" "debug")
NETWORK=$(set_default "$NETWORK" "simnet")
CHAIN=$(set_default "$CHAIN" "bitcoin")
BACKEND="btcd"
if [[ "$CHAIN" == "litecoin" ]]; then
    BACKEND="ltcd"
fi

mkdir -p /shared/lnd

exec lnd \
    --noencryptwallet \
    --logdir="/data" \
    "--$CHAIN.active" \
    "--$CHAIN.$NETWORK" \
    "--$CHAIN.node"="btcd" \
    "--$BACKEND.rpccert"="/shared/rpc/rpc.cert" \
    "--$BACKEND.rpchost"="btcd" \
    "--$BACKEND.rpcuser"="$RPCUSER" \
    "--$BACKEND.rpcpass"="$RPCPASS" \
    --rpclisten=0.0.0.0:10009 \
    --restlisten=0.0.0.0:8080 \
    --tlscertpath=/shared/lnd/tls.cert \
    --tlskeypath=/shared/lnd/tls.key \
    --tlsextradomain=lnd \
    --adminmacaroonpath=/shared/lnd/admin.macaroon \
    --debuglevel="$DEBUG" \
    "$@"
