# Okay, this is exciting, let's see if we can build a container that mimics the functionality of our current Linux build agents.
# Build a Docker image based on the Amazon Linux 2 Docker image.
FROM amazonlinux:2023



# Register the Microsoft RedHat repository

# install the tools from AWS-Cardprocess, AWSBLD, and Copernicus-AWS
RUN yum groupinstall -y  Development 
# RUN yum install -y dotnet-sdk-3.1
# RUN yum install --assumeyes docker
RUN yum install jq -y
RUN yum install wget -y
# RUN yum install postgresql -y
RUN dnf install dotnet-sdk-6.0 -y

RUN rpm --import https://packages.microsoft.com/keys/microsoft.asc
RUN wget -O /etc/yum.repos.d/microsoft-prod.repo https://packages.microsoft.com/config/fedora/35/prod.repo
RUN dnf install dotnet-sdk-7.0 -y
RUN dnf install dotnet-sdk-3.1 -y
# RUN dotnet new tool-manifest

ENV PATH $PATH:/root/.dotnet/tools
RUN dotnet tool install -g Amazon.Lambda.Tools
RUN dnf install -y dnf-plugins-core

RUN dnf update
RUN dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

RUN dnf remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-selinux docker-engine-selinux docker-engine

# RUN curl -fsSL https://get.docker.com -o get-docker.sh
# RUN sh ./get-docker.sh

RUN yum install docker -y

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

# RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
# RUN . ~/.nvm/nvm.sh
# RUN nvm install --lts
# RUN nvm install 16

# Download Azure DevOps Agent Software - okay actually this isn't happening right now, because we're downloading the agent software in the next step and running it to configure. But it would be faster if we included it here!
# Can be 'linux-x64', 'linux-arm64', 'linux-arm', 'rhel.6-x64'.
ENV TARGETARCH=linux-x64
# ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=true

WORKDIR /azp

COPY ./start.sh .
RUN chmod +x start.sh

ENTRYPOINT ["./start.sh"]
