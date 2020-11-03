#!/usr/bin/env bash

RANDOM_VALUE1=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 48 | head -n 1)
RANDOM_VALUE2=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 48 | head -n 1)
RANDOM_VALUE3=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 48 | head -n 1)

kubectl create secret generic jitsi-config \
  --from-literal=JICOFO_COMPONENT_SECRET="$RANDOM_VALUE1" \
  --from-literal=JVB_AUTH_PASSWORD="$RANDOM_VALUE2" \
  --from-literal=JICOFO_AUTH_PASSWORD="$RANDOM_VALUE3"
  
RANDOM_VALUE1=''
RANDOM_VALUE2=''
RANDOM_VALUE3=''
