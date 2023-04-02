# Okay, this is exciting, let's see if we can build a container that mimics the functionality of our current Linux build agents.
# Build a Docker image based on the Amazon Linux 2 Docker image.
FROM amazonlinux:2

# install the tools from AWS-Cardprocess, AWSBLD, and Copernicus-AWS
 RUN sudo yum install -y powershell 
 RUN sudo yum groupinstall Development 
 RUN sudo yum install dotnet-sdk-3.1.x 
 RUN sudo yum install docker 
 RUN sudo yum install jq -y
 RUN sudo yum install postgresql
 RUN sudo yum install dotnet-sdk-6.0 
 RUN sudo yum install dotnet-sdk-7.0
 
# Download and install the Azure DevOps Agent Software
~/$ mkdir myagent && cd myagent
~/myagent$ tar zxvf ~/Downloads/vsts-agent-linux-x64-3.218.0.tar.gz



# # Create user and enable root access
# RUN useradd --uid 1000 --shell /bin/bash -m --home-dir /home/ubuntu ubuntu && \
#     sed -i 's/%wheel\s.*/%wheel ALL=NOPASSWD:ALL/' /etc/sudoers && \
#     usermod -a -G wheel ubuntu

# Add the AWS Cloud9 SSH public key to the Docker container.
# This assumes a file named authorized_keys containing the
# AWS Cloud9 SSH public key already exists in the same
# directory as the Dockerfile.
# RUN mkdir -p /home/ubuntu/.ssh
# ADD ./authorized_keys /home/ubuntu/.ssh/authorized_keys
# RUN chown -R ubuntu /home/ubuntu/.ssh /home/ubuntu/.ssh/authorized_keys && \
# chmod 700 /home/ubuntu/.ssh && \
# chmod 600 /home/ubuntu/.ssh/authorized_keys

# # Update the password to a random one for the user ubuntu.
# RUN echo "ubuntu:$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)" | chpasswd

# # pre-install Cloud9 dependencies
# USER ubuntu
# RUN curl https://d2j6vhu5uywtq3.cloudfront.net/static/c9-install.sh | bash

# USER root
# # Start SSH in the Docker container.
# CMD ssh-keygen -A && /usr/sbin/sshd -D
