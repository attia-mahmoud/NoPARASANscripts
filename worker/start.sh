#!/usr/bin/env bash

# Check for the first argument
if [ -z "$1" ]; then
  echo "First argument is missing. Please provide a hostname."
  exit 1
fi

# Check for the second argument
if [ -z "$2" ]; then
  echo "Second argument is missing. Please provide an IP address."
  exit 1
fi

# Check for the third argument
if [ -z "$3" ]; then
  echo "Second argument is missing. Using a random port."
  random_number=$((RANDOM % 1001))
  port=$((random_number + 2000))
else
  port=$3
fi

# Start the ssh service
service ssh start

# REQUESTS_CA_BUNDLE=/home/root-ca.crt certbot certonly --manual --preferred-challenges dns -d worker1.nopasaran.com --server https://192.168.123.2:8443/acme/acme/directory --email you@nopasaran.com

# Request a certificate
step ssh certificate $1 id_ecdsa

# Add the private key to the ssh agent
eval "$(ssh-agent -s)"
ssh-add id_ecdsa

# Run port forwarding to the master node
ssh -R port:localhost:22 $2
