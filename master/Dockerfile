FROM ubuntu:latest

LABEL VERSION=1.0 \
      AUTHOR=NoPARASAN

# Set non-interactive frontend
ENV DEBIAN_FRONTEND=noninteractive

# Update and upgrade packages
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y nano iputils-ping git python3 wget openssh-server openssh-client net-tools

# Allow ssh connections 
EXPOSE 22

# Create symbolic link to set python3 as python
RUN ln -s /usr/bin/python3 /usr/bin/python

# Download get-pip.py and install pip for python
RUN wget -O - https://bootstrap.pypa.io/get-pip.py | python

# Install Ansible
RUN python -m pip install ansible

# Create the Ansible configuration files
RUN mkdir -p /etc/ansible && touch /etc/ansible/hosts

# Clone the required files from GitHub
RUN git clone https://github.com/attia-mahmoud/NoPASARANscripts.git

# Move the ssh_monitor script to the default directory
RUN mv /NoPASARANscripts/master/ssh_monitor.sh /NoPASARANscripts/master/start.sh  /

# Make scripts an executable
RUN chmod +x start.sh && chmod +x ssh_monitor.sh

# Clone the repository from GitHub
RUN git clone https://github.com/BenIlies/NoPASARAN.git

# Set working directory to NoPASARAN
WORKDIR /NoPASARAN

# Install Python dependencies
RUN python -m pip install -r requirements.txt

WORKDIR /
