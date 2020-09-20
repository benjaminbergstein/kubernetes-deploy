export DOMAIN_NAME ?= wips.link
export CLUSTER_NAME ?= test

export SUBDOMAIN_NAME = test.k8s

NODE_COUNT ?= 1
REGION ?= sfo3

define KUBECTL_CMD
kubectl
endef

define K8S_CMD
doctl k8s
endef

define CLUSTER_CMD
${K8S_CMD} cluster
endef

define CLUSTER_IP
$$(doctl -o json kubernetes cluster get dev | jq --raw-output '.[0].ipv4')
endef

define SERVICE_IP
$$(${KUBECTL_CMD} get -o json services ${POD_NAME}-lb | jq --raw-output '.status.loadBalancer.ingress[0].ip')
endef

define DNS_API
docker-compose \
	-f ../dns/docker-compose.yml \
	--project-directory=../dns \
	run api
endef
