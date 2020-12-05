#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# generate cert and key files
openssl req -newkey rsa:2048 -nodes -keyout /tmp/tmp.key -x509 -days 365 -out /tmp/tmp.crt -subj "/C=DE/ST=BW/L=Karlsruhe/O=PatrickWaldschmitt/CN=jitsi.patrick-nuc7i7"

{ # try
  "$DIR/create-ingress-certs.sh" /tmp/tmp.crt /tmp/tmp.key
}

# cleanup
rm -f /tmp/tmp.crt
rm -f /tmp/tmp.key
