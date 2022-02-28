################################################################################
# Build
################################################################################

IMAGE_NAME = opentelemetry-petclinic
ECR_URL = public.ecr.aws/sumologic
REPO_URL = $(ECR_URL)/$(IMAGE_NAME)
TAG = $(REPO_URL):latest
OT_JAR_VERSION = v1.11.1

#-------------------------------------------------------------------------------

.PHONY: get-ot-jar
get-ot-jar:
	wget -c https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/download/$(OT_JAR_VERSION)/opentelemetry-javaagent.jar

#-------------------------------------------------------------------------------

.PHONY: build
build:
	DOCKER_BUILDKIT=1 docker build \
		--tag $(TAG) \
		.

#-------------------------------------------------------------------------------

.PHONY: push
push:
	docker push $(TAG)

#-------------------------------------------------------------------------------

.PHONY: _login
_login:
	aws ecr-public get-login-password --region us-east-1 \
	| docker login --username AWS --password-stdin $(ECR_URL)

.PHONY: login
login:
	$(MAKE) _login \
		ECR_URL="$(ECR_URL)"
