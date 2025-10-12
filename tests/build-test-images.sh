#!/bin/sh
set -e

ARCH=${1:-amd64}
BASE_IMAGE=${2:-ubuntu/jre:test}
MAVEN_IMAGE=${4:-ubuntu/jre:test-maven}
MAVEN_BASE_IMAGE=${5:-maven:3.9-eclipse-temurin-25}
RELEASE=${6:-24.04}

(cd jre/ubuntu-${RELEASE}-headless && \
    rm -f *.rock && \
    rockcraft pack --build-for ${ARCH} && \
    rockcraft.skopeo copy oci-archive:jre_25-edge_${ARCH}.rock docker-daemon:${BASE_IMAGE})

docker build \
    -t ${MAVEN_IMAGE} \
    --build-arg ARCH=${ARCH} \
    --build-arg UID=$(id -u ${USER}) \
    --build-arg GID=$(id -g ${USER}) \
    --build-arg BASE_IMAGE=${BASE_IMAGE} \
    --build-arg MAVEN_IMAGE=${MAVEN_BASE_IMAGE} \
    -f tests/containers/maven/Dockerfile.${RELEASE} \
    tests/containers/maven
