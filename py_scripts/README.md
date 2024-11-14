# EC2 Instance Creation Script

This script automates the creation of EC2 instances in AWS using Python.

## Prerequisites

- AWS credentials configured
- Key pair created in AWS for EC2 instance SSH access

## Usage

To run this script:
```
python create_ec2.py --ami_id <AWS_AMI_ID> --instance_type <AWS_INSTANCE_TYPE> --subnet_id <AWS_SUBNET_ID> --key_name <AWS_KEY_ID> --security_group_name <AWS_SG_NAME> --region <AWS_REGION> --vpc_id <AWS_VPC_ID>
```

Note:
1. For AWS_AMI_ID you can select any AMI from any OS you can check in AMI Catalog in AWS Console.
2. For AWS_VPC_ID & AWS_SUBNET_ID make sure you are selecting a subnet within the VPC you have selected.
3. For AWS_SUBNET_ID please select a public subnet if you don't have a VPN or Bastion to access the EC2 from the private network.

For example: 
```
python3 create_ec2.py --ami_id ami-063d43db0594b521b --instance_type t2.micro --subnet_id subnet-0e0369ecd28a24ad2 --key_name dev-barkuni-key --security_group_name dev-barkuni-sg --region us-east-1 --vpc_id vpc-0edfa352381a03c4e
```
Note:

Amazon Linux 2023 AMI 64-bit (x86): ami-063d43db0594b521b

Public subnet: subnet-0e0369ecd28a24ad2

Key-pair: dev-barkuni-key