# Creating oss-base AMI

#### AMI: Amazon Linux 2023 AMI
#### VPC: oss-vpc
#### IAM: oss-ec2-deploy

## Preparation

1. Copy the `install_oss_base.sh` file to the following directory:
   ```bash
   /home/ec2-user/
   ```

2. Grant execution permission to the script:
   ```bash
   chmod +x /home/ec2-user/install_oss_base.sh
   ```

## How to Run

1. Run the script with root privileges:
   ```bash
   sudo ./install_oss_base.sh
   ```

