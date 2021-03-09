FROM golang:1.14.2 AS build-env

ENV HOVERFLY_VERSION 1.3.1
ADD https://github.com/SpectoLabs/hoverfly/archive/v${HOVERFLY_VERSION}.tar.gz /tmp/hoverfly_sources.tar.gz

ENV SOURCE_DIR /usr/local/go/src/github.com/SpectoLabs
RUN mkdir -p ${SOURCE_DIR} \
    && tar -xzf /tmp/hoverfly_sources.tar.gz -C ${SOURCE_DIR}/ \
    && mv ${SOURCE_DIR}/hoverfly-${HOVERFLY_VERSION} ${SOURCE_DIR}/hoverfly

RUN cd ${SOURCE_DIR}/hoverfly/core/cmd/hoverfly && CGO_ENABLED=0 GOOS=linux go install -ldflags "-s -w"

FROM alpine:3.13.2
RUN apk --no-cache add ca-certificates
COPY --from=build-env /usr/local/go/bin/hoverfly /bin/hoverfly
ENTRYPOINT ["/bin/hoverfly", "-listen-on-host=0.0.0.0"]
