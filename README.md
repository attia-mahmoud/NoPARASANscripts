# NoPASARANscripts

## Introduction

This repository contains scripts and files to be used by the master and worker nodes for the NoPASARAN project.

## Usage

To pull the docker image of the [master node](https://hub.docker.com/repository/docker/nopasaranhosts/master/general)

`docker pull nopasaranhosts/master`

and likewise for the [worker node](https://hub.docker.com/repository/docker/nopasaranhosts/worker/general)

`docker pull nopasaranhosts/worker`


When starting the container, run

`./start.sh`

to run the required scripts and initialize the host.


## Dockerfile Documentation

### Master
- `ENV DEBIAN_FRONTEND=noninteractive` prevents input requests during package installations
- `EXPOSE 22` to allow incoming SSH connections
- `RUN mkdir -p /etc/ansible creates the required Ansible config folder` and `touch /etc/ansible/hosts` creates the file that will contain the hostnames of all workers
- `RUN mv /NoPARASANscripts/master/ssh_monitor.sh /NoPASARANscripts/master/start.sh  /` moves the scripts to the default directory

### Worker
- `ENV DEBIAN_FRONTEND=noninteractive` prevents input requests during package installations
- `EXPOSE 22` to allow incoming SSH connections
- `RUN mv /NoPASARANscripts/root-ca.crt /home` places the CA root certificate to its appropriate location
- `mv /NoPASARANscripts/start.sh /` places the initialization script to its appropriate location and `RUN chmod +x start.sh` makes it an executable

## Script Documentation

### ssh_monitor.sh
This script continuously scans for connected SSH connections. It adds the hostnames of the open connections to the Ansible `hosts` file and otherwise removes the ones which have been disconnected.

### master/start.ssh
This script starts the ssh server and runs ssh_monitor.sh in the background.

### worker/start.sh
This script starts the ssh server and runs a certbot command that requests a certificate from the Certificate Authority after the completion of an ACME DNS-01 challenge.
