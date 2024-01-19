#!/bin/bash

# Definindo cores para a saída do terminal
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Extrai a região da AWS do arquivo variables.tf
region=$(sed -n -e '/variable "aws_region"/,/}/ p' variables.tf | awk -F\" '/default/ {print $2}')

# Verifica se a região foi extraída corretamente
if [ -z "$region" ]; then
    echo -e "${RED}Erro: Não foi possível extrair a região da AWS do arquivo variables.tf${NC}"
    exit 1
fi

# Obtém o nome da função Lambda
function_name=$(terraform output -raw function_name)

# Verifica se o nome da função foi obtido corretamente
if [ -z "$function_name" ]; then
    echo -e "${RED}Erro: Não foi possível obter o nome da função Lambda${NC}"
    exit 1
fi

echo -e "${GREEN}Invocando a função Lambda:${NC}"
echo ""

# Invoca a função Lambda
aws lambda invoke --region=$region --function-name=$function_name response.json > /dev/null 2>&1

# Verifica se a função Lambda foi invocada corretamente
if [ $? -ne 0 ]; then
    echo -e "${RED}Erro: Não foi possível invocar a função Lambda${NC}"
    exit 1
fi

echo -e "${GREEN}Resposta:${NC}"
echo ""

# Imprime a resposta da função Lambda
jq . response.json

echo ""

echo -e "${GREEN}Invocando a função Lambda via API Gateway:${NC}"
echo ""

# Invoca a função Lambda via API Gateway
curl "$(terraform output -raw base_url)/hello?Name=MyName"
