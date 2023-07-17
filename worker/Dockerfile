FROM ubuntu:latest

LABEL VERSION=0.1 \
      AUTHOR=NoPARASAN

# Set non-interactive frontend
ENV DEBIAN_FRONTEND=noninteractive

# Update and upgrade packages
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y nano iputils-ping git python3 wget certbot openssh-client openssh-server

# Create symbolic link to set python3 as python
RUN ln -s /usr/bin/python3 /usr/bin/python

# Download get-pip.py and install pip for python
RUN wget -O - https://bootstrap.pypa.io/get-pip.py | python

# Allow ssh connections
EXPOSE 22

# Clone the files from GitHub 
RUN git clone https://github.com/attia-mahmoud/NoPASARANscripts.git

# Move the root certificate to home directory
RUN mv /NoPASARANscripts/worker/root-ca.crt /home && mv /NoPASARANscripts/worker/start.sh /

# Make crtreq script an executable
RUN chmod +x start.sh

# Clone the repository from GitHub
RUN git clone https://github.com/BenIlies/NoPASARAN.git

# Set working directory to NoPASARAN
WORKDIR /NoPASARAN

# Install Python dependencies
RUN python -m pip install -r requirements.txt

WORKDIR /
