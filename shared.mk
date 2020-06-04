export CLUSTER_NAME ?= test
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
