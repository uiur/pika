#!/usr/bin/env bash

# exit from script if error was raised.
set -e

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

PARAMS=$(echo \
  "--rpcuser=$RPCUSER" \
  "--rpcpass=$RPCPASS" \
  --rpclisten=0.0.0.0 \
  --rpccert=/rpc/rpc.cert \
  --rpckey=/rpc/rpc.key
)

PARAMS="$PARAMS $@"

# Print command and start bitcoin node.
echo "Command: btcd $PARAMS"
exec btcd $PARAMS
