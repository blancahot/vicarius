import boto3
import argparse

def create_security_group(ec2, group_name, description, vpc_id):
    try:
        # Create the security group
        response = ec2.create_security_group(GroupName=group_name, Description=description, VpcId=vpc_id)
        security_group_id = response['GroupId']
        print(f'Security Group {group_name} created with ID: {security_group_id}')

        # Add inbound rule for SSH (port 22) from anywhere
        ec2.authorize_security_group_ingress(
            GroupId=security_group_id,
            IpPermissions=[
                {
                    'IpProtocol': 'tcp',
                    'FromPort': 22,
                    'ToPort': 22,
                    'IpRanges': [{'CidrIp': '0.0.0.0/0'}]
                }
            ]
        )

        # Add outbound rule to allow all traffic (IPv4 and IPv6)
        ec2.authorize_security_group_egress(
            GroupId=security_group_id,
            IpPermissions=[
                {
                    'IpProtocol': '-1',  # -1 indicates all protocols
                    'IpRanges': [{'CidrIp': '0.0.0.0/0'}],
                    'Ipv6Ranges': [{'CidrIpv6': '::/0'}]
                }
            ]
        )
        print("Inbound and outbound rules added to the security group.")
        return security_group_id

    except Exception as e:
        print(f"Error creating security group: {e}")
        return None

def create_ec2_instance(ami_id, instance_type, subnet_id, key_name, security_group_name, region, vpc_id):
    ec2 = boto3.client('ec2', region_name=region)

    # Create the security group
    security_group_id = create_security_group(ec2, security_group_name, "EC2 security group", vpc_id)

    if security_group_id:
        try:
            # Launch the EC2 instance
            response = ec2.run_instances(
                ImageId=ami_id,
                InstanceType=instance_type,
                SubnetId=subnet_id,
                KeyName=key_name,
                SecurityGroupIds=[security_group_id],
                MinCount=1,
                MaxCount=1
            )

            instance_id = response['Instances'][0]['InstanceId']
            print(f'EC2 instance created with Instance ID: {instance_id}')
            return instance_id

        except Exception as e:
            print(f'Error creating EC2 instance: {e}')
            return None
    else:
        print("Failed to create the security group.")
        return None

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Create an EC2 instance in a specific subnet with a security group.")
    parser.add_argument("--ami_id", required=True, help="AMI ID for the instance.")
    parser.add_argument("--instance_type", required=True, help="Type of EC2 instance, e.g., t2.micro.")
    parser.add_argument("--subnet_id", required=True, help="Subnet ID where the instance will be launched.")
    parser.add_argument("--key_name", required=True, help="Name of the SSH key pair.")
    parser.add_argument("--security_group_name", required=True, help="Name of the security group to create.")
    parser.add_argument("--region", required=True, help="AWS region, e.g., us-west-2.")
    parser.add_argument("--vpc_id", required=True, help="VPC ID where the security group will be created.")

    args = parser.parse_args()

    create_ec2_instance(
        ami_id=args.ami_id,
        instance_type=args.instance_type,
        subnet_id=args.subnet_id,
        key_name=args.key_name,
        security_group_name=args.security_group_name,
        region=args.region,
        vpc_id=args.vpc_id
    )