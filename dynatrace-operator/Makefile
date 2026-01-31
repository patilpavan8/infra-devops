SHELL := /bin/bash
IMAGE_REPO ?= registry.devops.com/infrastructure-applications/ci-images/helm
IMAGE_VERSION ?= main
DOCKER_CMD = docker run --quiet --rm --workdir "/data" --volume $(shell pwd):/data ${IMAGE_REPO}:${IMAGE_VERSION}
CHART_NAME = $(shell basename $(shell pwd))

.PHONY: all docker-login readme helm-lint checkov template package clean

all: docker-login readme helm-lint checkov package

docker-login:
	$(info Logging in to the GitLab Container Registry)
	docker login registry.devops.com

docker-prepare:
ifndef USE_LOCAL_IMAGE
	$(info Fetching helm container image)
	docker pull --quiet ${IMAGE_REPO}:${IMAGE_VERSION}
endif

readme: docker-prepare
	$(info Updating README.md file)
	${DOCKER_CMD} /scripts/helm-docs.sh

helm-lint: docker-prepare
	$(info Linting helm chart)
	${DOCKER_CMD} helm dependency update .
	${DOCKER_CMD} helm lint . --with-subcharts

checkov: docker-prepare
	$(info Analysing helm chart using checkov)
	${DOCKER_CMD} checkov --directory . --framework helm --quiet --compact --soft-fail --skip-check CKV_K8S_15,CKV_K8S_14,CKV_K8S_21,CKV_K8S_11,CKV_K8S_43

template: docker-prepare
ifdef KUBE_VERSION
	$(info Templating helm chart with kube version "${KUBE_VERSION}")
	${DOCKER_CMD} helm template ${CHART_NAME} . --namespace ${CHART_NAME} --values values.yaml --values values.override.yaml --include-crds --create-namespace --dependency-update --kube-version "${KUBE_VERSION}"
else
	$(info Templating helm chart)
	${DOCKER_CMD} helm template ${CHART_NAME} . --namespace ${CHART_NAME} --values values.yaml --values values.override.yaml --include-crds --create-namespace --dependency-update
endif

package: docker-prepare
	$(info Creating helm package preview)
	${DOCKER_CMD} helm package . --version "$(jx-release-version)-snapshot" --dependency-update

clean:
	$(info Cleaning up helm package preview)
	rm -rf *.tgz
	rm -rf charts
	rm -rf Chart.lock
