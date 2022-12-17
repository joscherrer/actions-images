FROM alpine:latest

ARG KUBE_VERSION=1.26.0
ARG HELM_VERSION=3.10.3
ARG TARGETOS=linux
ARG TARGETARCH=amd64

RUN apk -U upgrade \
    && apk add --no-cache ansible-core ca-certificates bash git openssh-client-default rsync \
    && wget -q https://storage.googleapis.com/kubernetes-release/release/v${KUBE_VERSION}/bin/${TARGETOS}/${TARGETARCH}/kubectl -O /usr/local/bin/kubectl \
    && wget -q https://get.helm.sh/helm-v${HELM_VERSION}-${TARGETOS}-${TARGETARCH}.tar.gz -O - | tar -xzO ${TARGETOS}-${TARGETARCH}/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm /usr/local/bin/kubectl \
    && chmod g+rwx /root \
    && helm plugin install https://github.com/databus23/helm-diff \
    && helm repo add "stable" "https://charts.helm.sh/stable" --force-update \
    && kubectl version --client \
    && helm version
