FROM golang:1.10-alpine3.7 AS builder

ENV HOVERFLY_VERSION 0.16.0
ADD https://github.com/SpectoLabs/hoverfly/archive/v${HOVERFLY_VERSION}.zip /tmp/hoverfly_sources.zip

ENV SOURCE_DIR /go/src/github.com/SpectoLabs
RUN mkdir -p ${SOURCE_DIR} \
    && unzip /tmp/hoverfly_sources.zip -d ${SOURCE_DIR}/ \
    && mv ${SOURCE_DIR}/hoverfly-${HOVERFLY_VERSION} ${SOURCE_DIR}/hoverfly

ENV GO15VENDOREXPERIMENT 1
RUN go install github.com/SpectoLabs/hoverfly/core/cmd/hoverfly/

FROM alpine:3.7
COPY --from=builder /go/bin/hoverfly /
ENTRYPOINT ["/hoverfly"]
