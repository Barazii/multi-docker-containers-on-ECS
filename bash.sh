aws cloudformation create-stack \
  --stack-name MyFargateApp \
  --template-body file://ecs-fargate-cln.yaml \
  --capabilities CAPABILITY_NAMED_IAM \
  --region eu-north-1