FROM ubuntu:latest

LABEL VERSION=1.0 \
      AUTHOR=NoPARASAN

# Set non-interactive frontend
ENV DEBIAN_FRONTEND=noninteractive

# Update and upgrade packages
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y nano iputils-ping git python3 wget

# Download step-ca and step-cli
RUN wget https://dl.smallstep.com/gh-release/cli/docs-cli-install/v0.23.4/step-cli_0.23.4_amd64.deb \
 && dpkg -i step-cli_0.23.4_amd64.deb

RUN wget https://dl.smallstep.com/gh-release/certificates/docs-ca-install/v0.23.2/step-ca_0.23.2_amd64.deb \
 && dpkg -i step-ca_0.23.2_amd64.deb

# Retrieve CA files
RUN git clone https://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@github.com/attia-mahmoud/NoPASARAN_CA.git

# Move all CA files to the root directory
RUN mv NoPASARAN_CA/.step /root

# Add the ACME provisioner to the CA by executing:
step ca provisioner add acme --type ACME

# Start the CA server
CMD step-ca $(step path)/config/ca.json
