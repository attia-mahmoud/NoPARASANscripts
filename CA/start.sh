#!/usr/bin/env bash

step ca init

step ca provisioner add acme --type ACME

step-ca $(step path)/config/ca.json
