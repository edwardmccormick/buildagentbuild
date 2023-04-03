# Okay, this is exciting, let's see if we can build a container that mimics the functionality of our current Linux build agents.
# Build a Docker image based on the Amazon Linux 2 Docker image.
FROM amazonlinux:2


# Man, this thing is apparently way important
# RUN yum install -y yum-utils
 # Register the Microsoft RedHat repository
RUN curl https://packages.microsoft.com/config/rhel/7/prod.repo | tee /etc/yum.repos.d/microsoft.repo
# RUN curl https://download.docker.com/linux/centos/docker-ce.repo | tee  /etc/yum.repos.d/docker.repo

# install the tools from AWS-Cardprocess, AWSBLD, and Copernicus-AWS
RUN yum install --assumeyes powershell
RUN yum groupinstall --assumeyes  Development 
RUN yum install --assumeyes dotnet-sdk-3.1
# RUN yum install --assumeyes docker
RUN yum install jq --assumeyes 
RUN yum install postgresql --assumeyes
RUN yum install dotnet-sdk-6.0 --assumeyes 
RUN yum install dotnet-sdk-7.0 --assumeyes
RUN yum install -y openssl-libs krb5-libs zlib libicu
RUN yum install -y wget ca-certificates
RUN yum -y install libicu
# RUN curl https://packages.efficios.com/repo.files/EfficiOS-RHEL7-x86-64.repo | tee /etc/yum.repos.d/efficios.repo
# RUN yum install rpmkeys

RUN yum updateinfo -y
RUN yum makecache
# RUN yum install -y lttng-ust


# Download Azure DevOps Agent Software

ENV TARGETARCH=rhel.6-x64
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=true

WORKDIR /azp

COPY ./start.sh .
RUN chmod +x start.sh

ENTRYPOINT ["./start.sh"]
