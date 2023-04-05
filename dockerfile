# Okay, this is exciting, let's see if we can build a container that mimics the functionality of our current Linux build agents.
# Build a Docker image based on the Amazon Linux 2 Docker image.
FROM amazonlinux:2


# Man, this thing is apparently way important
# RUN yum install -y yum-utils
 # Register the Microsoft RedHat repository
RUN curl https://packages.microsoft.com/config/rhel/7/prod.repo | tee /etc/yum.repos.d/microsoft.repo

# install the tools from AWS-Cardprocess, AWSBLD, and Copernicus-AWS
RUN yum install -y powershell
RUN yum groupinstall -y  Development 
RUN yum install -y dotnet-sdk-3.1
# RUN yum install --assumeyes docker
RUN yum install jq -y
RUN yum install postgresql -y
RUN yum install dotnet-sdk-6.0 -y
RUN yum install dotnet-sdk-7.0 -y
RUN dotnet tool install --global Amazon.Lambda.Tools
ENV PATH $PATH:/root/.dotnet/tools
RUN yum install -y openssl-libs krb5-libs zlib libicu
RUN yum install -y wget ca-certificates
RUN yum -y install libicu
# RUN curl https://packages.efficios.com/repo.files/EfficiOS-RHEL7-x86-64.repo | tee /etc/yum.repos.d/efficios.repo
# RUN yum install rpmkeys

RUN yum updateinfo -y
RUN yum makecache
# RUN yum install -y lttng-ust

RUN yum install -y yum-utils device-mapper-persistent-data lvm2

# RUN yum update
# RUN yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

RUN yum update
# RUN yum install docker

# RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
# RUN . ~/.nvm/nvm.sh
# RUN nvm install --lts
# RUN nvm install 16

# Download Azure DevOps Agent Software - okay actually this isn't happening right now, because we're downloading the agent software in the next step and running it to configure. But it would be faster if we included it here!

ENV TARGETARCH=rhel.6-x64
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=true

WORKDIR /azp

COPY ./start.sh .
RUN chmod +x start.sh

ENTRYPOINT ["./start.sh"]
