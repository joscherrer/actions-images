FROM alpine:latest

RUN apk add --no-cache ansible-core ansible-lint kubectl helm rsync
RUN helm plugin install https://github.com/databus23/helm-diff
