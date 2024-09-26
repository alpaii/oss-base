#!/bin/bash

# 시스템 업데이트
dnf update -y

# Docker 설치
dnf install -y docker

# Docker 서비스 시작 및 부팅 시 자동 시작 설정
systemctl start docker
systemctl enable docker

# ec2-user를 Docker 그룹에 추가하여 sudo 없이 Docker 명령을 실행할 수 있도록 설정
usermod -aG docker ec2-user

# 최신 Docker Compose 바이너리를 다운로드하여 /usr/local/bin에 설치합니다.
curl -L "https://github.com/docker/compose/releases/download/$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Docker Compose가 실행 가능하도록 권한을 부여합니다.
chmod +x /usr/local/bin/docker-compose

# AWS 리전 설정 (서울 리전: ap-northeast-2)
REGION="ap-northeast-2"

# CodeDeploy Agent 설치 파일 다운로드
dnf install -y ruby wget

# CodeDeploy Agent 설치 스크립트 다운로드
cd /home/ec2-user
wget https://aws-codedeploy-${REGION}.s3.${REGION}.amazonaws.com/latest/install

# 설치 스크립트에 실행 권한 부여
chmod +x ./install

# CodeDeploy Agent 설치
./install auto

# CodeDeploy Agent 시작
systemctl start codedeploy-agent

# CodeDeploy Agent 서비스 상태 확인
systemctl status codedeploy-agent

# CodeDeploy Agent 자동 시작 설정
systemctl enable codedeploy-agent

# Timezone 설정
timedatectl set-timezone Asia/Seoul

# jq 설치 (AWS Secrets Manager에서 JSON 데이터 처리에 필요)
dnf install -y jq


