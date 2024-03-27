# Variáveis
TF_CMD = terraform
TF_FLAGS = -auto-approve

# Targets
init:
	$(TF_CMD) init

validate:
	$(TF_CMD) validate

apply:
	$(TF_CMD) apply $(TF_FLAGS)

destroy:
	$(TF_CMD) destroy $(TF_FLAGS)

curl:
	@IP=$(shell $(TF_CMD) output -raw instance_public_ip) && \
	curl http://$$IP:8080

all: init validate apply curl destroy
