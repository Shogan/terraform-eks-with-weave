# Note: shebang is already included in the Terraform module userdata that gets generated. This script
# is appended after that so no need for shell/bash shebang.

sudo yum update -y

INSTANCEID=`curl -s http://169.254.169.254/latest/meta-data/instance-id`
aws ec2 modify-instance-attribute --instance-id $INSTANCEID --no-source-dest-check --region ${region}