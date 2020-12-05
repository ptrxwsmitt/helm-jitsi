#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

CERT_DOMAIN='jitsi.patrick-nuc7i7'

cat <<EOT >> /tmp/v3.ext
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = ${CERT_DOMAIN}
EOT

# generate cert and key files
openssl req -newkey rsa:2048 -nodes -keyout /tmp/tmp.key -x509 -days 365 -out /tmp/tmp.crt -subj "/C=DE/ST=BW/L=Karlsruhe/O=Patrick Waldschmitt/CN=${CERT_DOMAIN}" -extfile /tmp/v3.ext

{ # try
  "$DIR/create-ingress-certs.sh" /tmp/tmp.crt /tmp/tmp.key
}

# cleanup
rm -f /tmp/tmp.key

# echo
echo 'certificate available for download: /tmp/tmp.crt'
