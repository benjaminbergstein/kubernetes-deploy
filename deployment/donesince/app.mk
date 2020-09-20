export SERVICE ?= server
export DOCKER_TAG ?= latest
export DOCKER_IMAGE=registry.digitalocean.com/benbergstein/donesince/${SERVICE}/production:${DOCKER_TAG}

export TARGET_TEMPLATE ?= -${SERVICE}
export SUBDOMAIN_NAME=${SERVICE}.donesince.k8s
DEPLOY_FILE = ${PROJECT}/${ENVIRONMENT}-${SERVICE}${TARGET_TEMPLATE}.yaml

export POSTGRES_USER=postgres
export POSTGRES_PASSWORD = $(shell kubectl get secret --namespace default donesince-postgresql -o jsonpath="{.data.postgresql-password}" | base64 --decode)
export POSTGRES_HOST=donesince-postgresql.default.svc.cluster.local
export POSTGRES_DB=donesince
export DATABASE_URL=postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:5432/${POSTGRES_DB}?schema=public
export SERVER_URL=http://donesince-server-production-lb.default.svc.cluster.local
