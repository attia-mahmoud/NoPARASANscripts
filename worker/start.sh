#!/usr/bin/env bash

# Check for the first argument
if [ -z "$1" ]; then
  echo "First argument is missing. Please provide a CA URL."
  exit 1
fi

# Check for the second argument
if [ -z "$2" ]; then
  echo "Second argument is missing. Please provide a CA Fingerprint."
  exit 1
fi

# Check for the third argument
if [ -z "$3" ]; then
  echo "Third argument is missing. Please provide the hostname of this worker."
  exit 1
fi

# Check for the fourth argument
if [ -z "$4" ]; then
  echo "Fourth argument is missing. Please provide an IP address of a master."
  exit 1
fi

# Check for the fifth argument
if [ -z "$5" ]; then
  echo "Fifth argument is missing. Using a random port."
  random_number=$((RANDOM % 1001))
  port=$((random_number + 2000))
else
  port=$3
fi

# Bootstrap the CA configuration
step ca bootstrap --ca-url $1 --fingerprint $2

# Start the ssh service
service ssh start

# REQUESTS_CA_BUNDLE=/home/root-ca.crt certbot certonly --manual --preferred-challenges dns -d $3 --server https://$1:443/acme/acme/directory --email you@nopasaran.com

# Request a certificate
step ssh certificate $3 id_ecdsa

# Add the private key to the ssh agent
eval "$(ssh-agent -s)"
ssh-add id_ecdsa

# Run port forwarding to the master node
ssh -R $port:localhost:22 $4
