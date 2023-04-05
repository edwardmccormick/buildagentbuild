# Okay, this is exciting, let's see if we can build a container that mimics the functionality of our current Linux build agents.
# Build a Docker image based on the Amazon Linux 2 Docker image.
FROM ubuntu:22.04
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

RUN apt-get install -y wget
RUN apt-get -y install zip


# Get Ubuntu version
# RUN declare repo_version=$(if command -v lsb_release &> /dev/null; then lsb_release -r -s; else grep -oP '(?<=^VERSION_ID=).+' /etc/os-release | tr -d '"'; fi)

# Download Microsoft signing key and repository
RUN wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb

# Install Microsoft signing key and repository
RUN dpkg -i packages-microsoft-prod.deb

# Clean up
RUN rm packages-microsoft-prod.deb

# Update packages
RUN apt update

RUN apt-get install -y dotnet-sdk-6.0
# RUN apt-get install -y dotnet-sdk-3.1
RUN apt-get install -y dotnet-sdk-7.0

ENV PATH $PATH:/root/.dotnet/tools
RUN dotnet tool install -g Amazon.Lambda.Tools

# Update the list of packages
RUN apt-get update
# Install pre-requisite packages.
RUN apt-get install -y wget apt-transport-https software-properties-common
# # Download the Microsoft repository GPG keys
# RUN -q "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb"
# # Register the Microsoft repository GPG keys
# RUN dpkg -i packages-microsoft-prod.deb
# # Delete the the Microsoft repository GPG keys file 
# RUN rm packages-microsoft-prod.deb
# # Update the list of packages after we added packages.microsoft.com
# RUN apt-get update
# Install PowerShell
RUN apt-get install -y powershell

#Install Buildah(?)
RUN apt-get -y install buildah

RUN apt-get -y -qq update
RUN apt-get -y install bats \
    btrfs-progs\
    git \
    libapparmor-dev\
    libdevmapper-dev\
    libglib2.0-dev\
    libgpgme11-dev\
    libseccomp-dev\
    libselinux1-dev\
    skopeo\
    go-md2man\
    make\
    runc
RUN apt-get -y install golang-1.18

RUN cd ~\
    mkdir buildah\
    cd /buildah\
    export GOPATH=`pwd`\
    git clone https://github.com/containers/buildah ./src/github.com/containers/buildah\
    cd ./src/github.com/containers/buildah\
    PATH=/usr/lib/go-1.18/bin:$PATH make runc all SECURITYTAGS="apparmor seccomp"\
    make install install.runc
# RUN buildah --help

# Install NVM
RUN curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

RUN curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

# RUN nvm install node 
# RUN nvm install 16.14.0  

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

# ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=true

WORKDIR /azp

COPY ./start.sh .
RUN chmod +x start.sh

ENTRYPOINT ["./start.sh"]
