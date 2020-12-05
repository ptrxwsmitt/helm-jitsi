#!/usr/bin/env bash

CERT_FILE=$1
KEY_FILE=$2

# print usage if no input is given or -h, --help is used
if [ '' == "$CERT_FILE" ] || [ '' == "$KEY_FILE" ] || [ '-h' == "$1" ] || [ '--help' == "$1" ]; then
  echo -e "USAGE: ${BASH_SOURCE[0]} <CERT_FILE> <KEY_FILE>"
  exit 0
fi

# check if files exist
if [ ! -f "$CERT_FILE" ]; then
  echo 'cert file does not exist'
  exit 1
fi

if [ ! -f "$KEY_FILE" ]; then
  echo 'key file does not exist'
  exit 2
fi

# turn file content into base64 and apply secret
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: ingress-certs
data:
  tls.crt: $(cat "${CERT_FILE}" | base64 --wrap=0)
  tls.key: $(cat "${KEY_FILE}" | base64 --wrap=0)
type: kubernetes.io/tls
EOF
