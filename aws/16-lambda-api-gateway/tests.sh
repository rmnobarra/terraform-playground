#!/bin/bash

# Setups terminal colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Extracts the AWS region from the variables.tf file
region=$(sed -n -e '/variable "aws_region"/,/}/ p' variables.tf | awk -F\" '/default/ {print $2}')

# Verify if the region was extracted correctly
if [ -z "$region" ]; then
    echo -e "${RED}Error: Was not possible extract aws region from variables.tf${NC}"
    exit 1
fi

# Gets the Lambda function name
function_name=$(terraform output -raw function_name)

# Verify if the function name was obtained correctly
if [ -z "$function_name" ]; then
    echo -e "${RED}Error: Was not possible get lambda function name${NC}"
    exit 1
fi

echo -e "${GREEN}Invoking lambda function:${NC}"
echo ""

# Invokes the Lambda function
aws lambda invoke --region=$region --function-name=$function_name response.json > /dev/null 2>&1

# Verifies if the Lambda function was invoked correctly
if [ $? -ne 0 ]; then
    echo -e "${RED}Error: Was not possible invoke Lambda${NC}"
    exit 1
fi

echo -e "${GREEN}Response:${NC}"
echo ""

# Prints the Lambda function response
jq . response.json

echo ""

echo -e "${GREEN}Invoking a lambda function via API Gateway:${NC}"
echo ""

# Invokes the Lambda function via API Gateway
curl "$(terraform output -raw base_url)/hello?Name=MyName"
