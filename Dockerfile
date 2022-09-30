FROM golang:1.19 AS build

COPY . /workspace/

ENV CGO_ENABLED=0
RUN cd /workspace && go build .


FROM alpine:latest
RUN apk add --no-cache ca-certificates bash
COPY --from=build /workspace/hcloud-cloud-controller-manager /bin/hcloud-cloud-controller-manager
ENTRYPOINT ["/bin/hcloud-cloud-controller-manager"]
