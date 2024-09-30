#!/bin/bash

# System update
dnf update -y

# Install Docker
dnf install -y docker

# Start Docker service and enable it to start automatically on boot
systemctl start docker
systemctl enable docker

# Add ec2-user to the Docker group to allow Docker commands to be run without sudo
usermod -aG docker ec2-user

# Download the latest Docker Compose binary and install it to /usr/local/bin
curl -L "https://github.com/docker/compose/releases/download/$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Grant execute permission for Docker Compose
chmod +x /usr/local/bin/docker-compose

# Set AWS region (Seoul region: ap-northeast-2)
REGION="ap-northeast-2"

# Download CodeDeploy Agent installation files
dnf install -y ruby wget

# Download the CodeDeploy Agent installation script
cd /home/ec2-user
wget https://aws-codedeploy-${REGION}.s3.${REGION}.amazonaws.com/latest/install

# Grant execute permission to the installation script
chmod +x ./install

# Install CodeDeploy Agent
./install auto

# Start CodeDeploy Agent
systemctl start codedeploy-agent

# Check the status of the CodeDeploy Agent service
systemctl status codedeploy-agent

# Enable CodeDeploy Agent to start automatically on boot
systemctl enable codedeploy-agent

# Set timezone
timedatectl set-timezone Asia/Seoul

# Install jq (required for processing JSON data from AWS Secrets Manager)
dnf install -y jq