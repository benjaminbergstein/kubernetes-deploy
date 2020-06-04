include ../shared.mk

export PROJECT ?= blog
export ENVIRONMENT ?= production
export POD_NAME ?= ${PROJECT}-${ENVIRONMENT}
export SERVICE ?= app

DOCKER_HOST ?= registry.digitalocean.com
DOCKER_REPO ?= benbergstein
DOCKER_TAG ?= latest

export DOCKER_IMAGE ?= ${DOCKER_HOST}/${DOCKER_REPO}/${PROJECT}/${ENVIRONMENT}/${SERVICE}:${DOCKER_TAG}

TEMPLATE_FILE ?= ${PROJECT}/template.yaml
DEPLOY_FILE ?= ${PROJECT}/${ENVIRONMENT}.yaml

${DEPLOY_FILE}:
	envsubst < ${TEMPLATE_FILE} > $@

all: deploy
deploy: clean apply
apply: ${DEPLOY_FILE}
	${KUBECTL_CMD} apply -f $<

clean:
	rm ${DEPLOY_FILE}

destroy:
	${KUBECTL_CMD} delete -f ${DEPLOY_FILE}
