ARG PETCLINIC_REPO
ARG PETCLINIC_TAG

ARG BASE_IMAGE=ubuntu/jre:21-24.04_edge


FROM ubuntu:noble-20250127 AS builder

ENV PETCLINIC_TAG=${PETCLINIC_TAG:-spring-boot-3.0.6}
ENV PETCLINIC_REPO=${PETCLINIC_REPO:-https://github.com/vpa1977/spring-petclinic}

RUN DEBIAN_FRONTEND=noninteractive apt-get install -U -y git \
        default-jdk-headless

RUN git clone $PETCLINIC_REPO

RUN cd spring-petclinic && git checkout $PETCLINIC_TAG && ./mvnw package

FROM $BASE_IMAGE

# add pebble layer definition
COPY 001-spring-petclinic.yaml /var/lib/pebble/default/layers/

# copy petclinic sample
COPY --from=builder \
    /spring-petclinic/target/spring-petclinic-3.0.0-SNAPSHOT.jar /spring-petclinic.jar
