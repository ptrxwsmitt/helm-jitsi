#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


CERT_DOMAIN='jitsi.patrick-nuc7i7'

CERT_DIR='/tmp/keygen'
CA_KEY_FILE="${CERT_DIR}/rootCA.key"
CA_CRT_FILE="${CERT_DIR}/rootCA.crt"
CA_SUBJECT="/C=DE/ST=Baden-Wuerttemberg/L=Karlsruhe/O=Patrick Waldschmitt"
DEVICE_KEY_FILE="${CERT_DIR}/device.key"
DEVICE_CSR_FILE="${CERT_DIR}/device.csr"
DEVICE_CRT_FILE="${CERT_DIR}/device.crt"
V3_FILE="${CERT_DIR}/v3.ext"
SUBJECT="/C=DE/ST=BW/L=Karlsruhe/O=Patrick Waldschmitt/CN=${CERT_DOMAIN}"

rm -rf ${CERT_DIR}
mkdir -p ${CERT_DIR}

echo 'root certificate key and pem'
openssl req -new -sha256 -nodes -newkey rsa:2048 -keyout ${CA_KEY_FILE} -subj "${CA_SUBJECT}" -out ${CA_CRT_FILE} -x509 -days 1024 

echo 'device certificate key and csr'
openssl req -new -sha256 -nodes -newkey rsa:2048 -keyout ${DEVICE_KEY_FILE} -subj "${SUBJECT}" -out ${DEVICE_CSR_FILE}

cat <<EOT >> ${V3_FILE}
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = ${CERT_DOMAIN}
EOT

echo 'device certificate'
openssl x509 -req -sha256 -in ${DEVICE_CSR_FILE} -CA ${CA_CRT_FILE} -CAkey ${CA_KEY_FILE} -CAcreateserial -out ${DEVICE_CRT_FILE} -days 365  -extfile ${V3_FILE}

{ # try
  "$DIR/create-ingress-certs.sh" ${DEVICE_CRT_FILE} ${DEVICE_KEY_FILE}
}

# cleanup
rm -f ${CA_KEY_FILE}
rm -f ${DEVICE_CSR_FILE}
rm -f ${DEVICE_KEY_FILE}

# echo
echo "certificates available for download: ${CA_CRT_FILE} ${DEVICE_CRT_FILE}"
