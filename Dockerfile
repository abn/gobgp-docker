FROM fedora:latest
MAINTAINER Arun Neelicattu <arun.neelicattu@gmail.com>

RUN dnf -y upgrade

# install base requirements
RUN dnf -y install golang git hg 
RUN dnf -y install findutils

# prepare gopath
ENV GOPATH /go
ENV PATH /go/bin:${PATH}
RUN mkdir -p ${GOPATH}

ARG BINARY
ARG VERSION

ENV PACKAGE github.com/osrg/gobgp/${BINARY}
ENV VERSION ${VERSION}
ENV GO_BUILD_TAGS netgo
ENV CGO_ENABLED 1

COPY ./loadbins /usr/bin/loadbins
RUN go get ${PACKAGE}

WORKDIR ${GOPATH}/src/${PACKAGE}
RUN git checkout -b v${VERSION} v${VERSION}

RUN mkdir bin
RUN go build \
        -tags "${GO_BUILD_TAGS}" \
        -ldflags "-s -w -X ${PACKAGE}/version.Version ${VERSION}" \
        -v -a \
        -installsuffix cgo \
        -o ./bin/${BINARY}

ENV ROOTFS rootfs
ENV DEST ${ROOTFS}

RUN mkdir ${ROOTFS}

RUN loadbins ./bin/${BINARY}

RUN find ${ROOTFS} -name "*.so" -exec loadbins {} \;

RUN mkdir -p ${ROOTFS}/usr/bin
RUN cp ./bin/${BINARY} ${ROOTFS}/usr/bin/

# build image
COPY Dockerfile.${BINARY} Dockerfile

ENV BINARY ${BINARY}
CMD docker build --no-cache -t alectolytic/${BINARY} ${PWD}
