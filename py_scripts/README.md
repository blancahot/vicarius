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
python create_ec2.py --ami_id ami-0abcdef1234567890 --instance_type t2.micro --subnet_id subnet-0123456789abcdef --key_name my-key --security_group_name my-sec-group --region us-west-2 --vpc_id vpc-0123456789abcdef
```

