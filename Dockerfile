# Builder
FROM golang as builder

MAINTAINER codingPear

RUN apt-get update && apt-get install -y git dmsetup && apt-get clean

RUN git clone https://github.com/google/cadvisor.git /go/src/github.com/google/cadvisor

WORKDIR /go/src/github.com/google/cadvisor

RUN make build

# Image for usage
FROM debian

COPY --from=builder /go/src/github.com/google/cadvisor/cadvisor /usr/bin/cadvisor

MAINTAINER codingPear

EXPOSE 8080

ENTRYPOINT ["/usr/bin/cadvisor", "-logtostderr"]
