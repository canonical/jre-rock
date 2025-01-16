#!/bin/sh
set -e

ARCH=${1:-amd64}
BASE_IMAGE=${2:-ubuntu/jre:test}
BUILD_IMAGE=${3:-ubuntu/jre:test-builder}
MAVEN_IMAGE=${4:-ubuntu/jre:test-maven}
MAVEN_BASE_IMAGE=${5:-maven:3.9.9-eclipse-temurin-21}
RELEASE=${6:-24.04}

(cd jre/ubuntu-${RELEASE}-headless && \
    rockcraft pack --build-for ${ARCH} && \
    rockcraft.skopeo copy oci-archive:jre_21-edge_${ARCH}.rock docker-daemon:${BASE_IMAGE})

docker build \
    -t ${BUILD_IMAGE} \
    --build-arg UID=$(id -u ${USER}) \
    --build-arg GID=$(id -g ${USER}) \
    -f tests/containers/builder/Dockerfile.${RELEASE} \
    tests/containers/builder

docker build \
    -t ${MAVEN_IMAGE} \
    --build-arg ARCH=${ARCH} \
    --build-arg UID=$(id -u ${USER}) \
    --build-arg GID=$(id -g ${USER}) \
    --build-arg BASE_IMAGE=${BASE_IMAGE} \
    --build-arg MAVEN_IMAGE=${MAVEN_BASE_IMAGE} \
    -f tests/containers/maven/Dockerfile.${RELEASE} \
    tests/containers/maven
