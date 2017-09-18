FROM alpine:3.6 AS builder
RUN apk add -U unzip && rm -rf /var/cache/apk/*
ENV HOVERFLY_VERSION 0.14.0
ADD https://github.com/SpectoLabs/hoverfly/releases/download/v${HOVERFLY_VERSION}/hoverfly_bundle_linux_amd64.zip /
RUN unzip hoverfly_bundle_linux_amd64.zip

FROM golang:1.8.1
COPY --from=builder /hoverfly /
EXPOSE 8500 8888
ENTRYPOINT ["/hoverfly"]
