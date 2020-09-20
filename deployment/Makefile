include ../shared.mk

export PROJECT ?= blog

export ENVIRONMENT ?= production
export POD_NAME ?= ${PROJECT}-${SERVICE}-${ENVIRONMENT}
export SERVICE ?= app
export PORT ?= 8080

DOCKER_HOST ?= registry.digitalocean.com
DOCKER_REPO ?= benbergstein
DOCKER_TAG ?= latest

export DOCKER_IMAGE ?= ${DOCKER_HOST}/${DOCKER_REPO}/${PROJECT}/${ENVIRONMENT}/${SERVICE}:${DOCKER_TAG}

TARGET_TEMPLATE ?= 
TEMPLATE_FILE ?= ${PROJECT}/template${TARGET_TEMPLATE}.yaml
DEPLOY_FILE ?= ${PROJECT}/${ENVIRONMENT}${TARGET_TEMPLATE}.yaml

include ./${PROJECT}/app.mk

${DEPLOY_FILE}:
	envsubst < ${TEMPLATE_FILE} > $@

all: deploy
deploy: clean apply
apply: ${DEPLOY_FILE}
	${KUBECTL_CMD} apply -f $<

deploy-dns:
	./wait-for-service.sh ${POD_NAME}-lb
	${DNS_API} create-record ${DOMAIN_NAME} '${SUBDOMAIN_NAME}' A ${SERVICE_IP}

deploy-cname:
	${DNS_API} create-record ${APP_CNAME} 'www' CNAME '${SUBDOMAIN_NAME}.${DOMAIN_NAME}'
	${DNS_API} create-record ${APP_CNAME} '' CNAME '${SUBDOMAIN_NAME}.${DOMAIN_NAME}'

destroy-cname:
	# ${DNS_API} destroy-record ${APP_CNAME} 'www'
	${DNS_API} destroy-record ${APP_CNAME} ''

await-rollout:
	${KUBECTL_CMD} rollout status deployment/${POD_NAME}

destroy-dns:
	${DNS_API} destroy-record ${DOMAIN_NAME} '${SUBDOMAIN_NAME}'

clean:
	-rm ${DEPLOY_FILE}

destroy:
	${KUBECTL_CMD} delete -f ${DEPLOY_FILE}
