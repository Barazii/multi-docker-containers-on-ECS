AWS_REGION := eu-north-1
AWS_ACCOUNT_ID := 482497089777
ECR_URL := $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com

IMAGE1 := backend
IMAGE2 := frontend

.PHONY: build push login create

create:
	aws ecr create-repository --repository-name $(IMAGE1) --region $(AWS_REGION) || true
	aws ecr create-repository --repository-name $(IMAGE2) --region $(AWS_REGION) || true

build:
	docker compose -f docker-compose.yaml build

login:
	aws ecr get-login-password --region $(AWS_REGION) | docker login --username AWS --password-stdin $(ECR_URL)

push: login
	docker tag $(IMAGE1):latest $(ECR_URL)/$(IMAGE1):latest
	docker tag $(IMAGE2):latest $(ECR_URL)/$(IMAGE2):latest
	docker push $(ECR_URL)/$(IMAGE1):latest
	docker push $(ECR_URL)/$(IMAGE2):latest