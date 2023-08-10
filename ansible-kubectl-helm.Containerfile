FROM alpine:latest

ARG HELM_VERSION=3.10.3
ARG TARGETOS=linux
ARG TARGETARCH=amd64

RUN apk -U upgrade \
    && apk add --no-cache ansible-core ca-certificates bash git openssh-client-default rsync jq terraform kubectl helm vault \
    && chmod g+rwx /root \
    && helm plugin install https://github.com/databus23/helm-diff \
    && helm repo add "stable" "https://charts.helm.sh/stable" --force-update \
    && kubectl version --client \
    && helm version