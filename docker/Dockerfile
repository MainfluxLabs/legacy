FROM golang:1.21-alpine AS builder
ARG SVC
ARG VERSION
ARG COMMIT
ARG TIME

WORKDIR /go/src/github.com/MainfluxLabs/legacy
COPY . .
RUN apk update \
    && apk add make \
    && make $SVC \
    && mv build/mainfluxlabs-$SVC /exe

FROM gcr.io/distroless/static:nonroot
COPY --from=builder /exe /
USER nonroot
ENTRYPOINT ["/exe"]
