#!/usr/bin/env bash

# Check for the first argument
if [-z "$1" ]; then
  echo "First argument is missing. Please provide a CA URL."
  exit 1
fi

# Check for the second argument
if [-z "$2" ]; then
  echo "First argument is missing. Please provide a CA Fingerprint."
  exit 1
fi

# Bootstrap the CA configuration
RUN step ca bootstrap --ca-url $1 --fingerprint $2

# Add the SSH User Public Key
RUN step ssh config --roots > /etc/ssh/ssh_user_key.pub && echo "TrustedUserCAKeys /etc/ssh/ssh_user_key.pub" >> /etc/ssh/sshd_config

# Start the SSH server
service ssh start

# REQUESTS_CA_BUNDLE=/home/root-ca.crt certbot certonly --manual --preferred-challenges dns -d master1.nopasaran.com --server https://192.168.123.2:8443/acme/acme/directory --email you@nopasaran.com

# Run the script to monitor incoming SSH connections
./ssh_monitor.sh &
