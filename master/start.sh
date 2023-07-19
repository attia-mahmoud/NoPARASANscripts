#!/usr/bin/env bash

service ssh start

REQUESTS_CA_BUNDLE=/home/root-ca.crt certbot certonly --manual --preferred-challenges dns -d master1.nopasaran.com --server https://192.168.123.2:8443/acme/acme/directory --email you@nopasaran.com

./ssh_monitor.sh &
