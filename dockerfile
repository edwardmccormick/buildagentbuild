# Okay, this is exciting, let's see if we can build a container that mimics the functionality of our current Linux build agents.
# Build a Docker image based on the Amazon Linux 2 Docker image.
FROM ubuntu:20.04
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -qq --no-install-recommends \
    apt-transport-https \
    apt-utils \
    ca-certificates \
    curl \
    git \
    iputils-ping \
    jq \
    lsb-release \
    software-properties-common

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Can be 'linux-x64', 'linux-arm64', 'linux-arm', 'rhel.6-x64'.
ENV TARGETARCH=linux-x64

# Man, this thing is apparently way important
# RUN yum install -y yum-utils
 # Register the Microsoft RedHat repository
# RUN curl https://packages.microsoft.com/config/rhel/7/prod.repo | tee /etc/yum.repos.d/microsoft.repo
# RUN curl https://download.docker.com/linux/centos/docker-ce.repo | tee  /etc/yum.repos.d/docker.repo

# install the tools from AWS-Cardprocess, AWSBLD, and Copernicus-AWS
# RUN yum install --assumeyes powershell
# RUN apt-get install -y  Development 
# RUN apt-get install -y dotnet-sdk-3.1
# RUN apt-get install -y liblttng-ust0 libkrb5-3 zlib1g debsums
# # RUN yum install --assumeyes docker
# RUN apt-get install jq -y
# # RUN yum install postgresql --assumeyes
# RUN apt-get install dotnet-sdk-6.0 -y 
# RUN apt-get install dotnet-sdk-7.0 -y
# # RUN apt install -y openssl-libs krb5-libs zlib libicu
# RUN apt-get install -y wget ca-certificates
# RUN apt-get -y install libicu

# Download Azure DevOps Agent Software

ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=true

WORKDIR /azp

COPY ./start.sh .
RUN chmod +x start.sh

ENTRYPOINT ["./start.sh"]
