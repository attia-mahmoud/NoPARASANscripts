#!/usr/bin/env bash

if [-z "$1" ]; then
  echo "First argument is missing. Please provide a hostname."
  exit 1
fi

service ssh start

# REQUESTS_CA_BUNDLE=/home/root-ca.crt certbot certonly --manual --preferred-challenges dns -d worker1.nopasaran.com --server https://192.168.123.2:8443/acme/acme/directory --email you@nopasaran.com

step ssh certificate $1 id_ecdsa

eval "$(ssh-agent -s)"
ssh-add id_ecdsa

#Run port forwarding with an arbitrary port
random_number=$((RANDOM % 1001))
port=$((random_number + 2000))
ssh -R $port:localhost:22 192.168.123.2
