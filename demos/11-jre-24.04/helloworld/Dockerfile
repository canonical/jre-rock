FROM ubuntu:noble-20260610 AS builder

RUN DEBIAN_FRONTEND=noninteractive apt-get install -U -y \
    default-jdk-headless

ADD HelloWorld.java /
RUN javac -d / /HelloWorld.java

FROM ubuntu/jre:11-24.04_edge

COPY --from=builder HelloWorld.class /

CMD [ "exec", "java", "-cp", "/", "HelloWorld" ]
