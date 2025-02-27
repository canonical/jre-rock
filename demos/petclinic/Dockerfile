ARG PETCLINIC_REPO
ARG PETCLINIC_TAG

ARG BASE_IMAGE=ubuntu/jre:21_edge
ARG USER=app
ARG UID=101
ARG GROUP=app
ARG GID=101

FROM ubuntu:noble-20250127 AS builder

ENV PETCLINIC_TAG=${PETCLINIC_TAG:-6328d2c}
ENV PETCLINIC_REPO=${PETCLINIC_REPO:-https://github.com/spring-projects/spring-petclinic}

RUN DEBIAN_FRONTEND=noninteractive apt-get install -U -y git \
        default-jdk-headless

RUN git clone $PETCLINIC_REPO

RUN cd spring-petclinic && git checkout $PETCLINIC_TAG && ./mvnw package

FROM $BASE_IMAGE

ARG USER
ARG UID
ARG GID
USER $UID:$GID

# add pebble layer definition
ADD 001-spring-petclinic.yaml /var/lib/pebble/default/layers/

# copy petclinic sample
COPY --chown=$UID:$GID --from=builder \
    /spring-petclinic/target/spring-petclinic-3.4.0-SNAPSHOT.jar /spring-petclinic.jar
