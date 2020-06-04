include ../shared.mk

deploy:
	${CLUSTER_CMD} create ${CLUSTER_NAME} \
		--auto-upgrade \
		--count ${NODE_COUNT} \
		--wait

authenticate:
	${CLUSTER_CMD} kubeconfig save ${CLUSTER_NAME}

authorize:
	${KUBECTL_CMD} create secret generic regcred \
		--from-file=.dockerconfigjson=${HOME}/.docker/config.json \
		--type=kubernetes.io/dockerconfigjson

destroy:
	${CLUSTER_CMD} rm ${CLUSTER_NAME}
