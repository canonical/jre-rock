ARG BASE_IMAGE=ubuntu/jre:17-24.04_edge

FROM ubuntu:noble-20250127 AS builder

RUN DEBIAN_FRONTEND=noninteractive apt-get install -U -y \
    default-jdk-headless

ADD HelloWorld.java /
RUN javac -d / /HelloWorld.java

FROM ${BASE_IMAGE}

COPY --from=builder HelloWorld.class /

CMD [ "exec", "java", "-cp", "/", "HelloWorld" ]
