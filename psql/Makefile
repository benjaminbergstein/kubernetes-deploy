DEPLOYMENT_NAME ?= my-release

values-production.yml:
	curl https://raw.githubusercontent.com/bitnami/charts/master/bitnami/postgresql/values-production.yaml > psql/values-production.yaml

add-repo:
	helm repo add bitnami https://charts.bitnami.com/bitnami

deploy: values-production.yaml
	helm install -f values-production.yaml --set postgresqlDatabase=${DEPLOYMENT_NAME} ${DEPLOYMENT_NAME} bitnami/postgresql

destroy:
	helm uninstall ${DEPLOYMENT_NAME}

setup: add-repo install
