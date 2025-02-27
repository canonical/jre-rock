# Chiselled OpenJDK 21

This directory contains the image recipes of Chiselled OpenJDK 21. These
images are smaller in size, hence less prone to vulnerabilities. Know
more about chisel [here](https://github.com/canonical/chisel).

We currently have Chiselled OpenJDK 21 on Noble. See
[rockcraft.yaml](./ubuntu-24.04-headless/rockcraft.yaml).

### Building the image(s)

Build the rock in the usual way:

```sh
cd ubuntu-24.04-headless && rockcraft pack
```

### Running the image(s)

Import the recently created rock into Docker using
[skopeo](https://github.com/containers/skopeo).

```sh
$ rockcraft.skopeo copy \
 oci-archive:jre_21-edge_amd64.rock \
 docker-daemon:ubuntu/jre:21_edge
```

The image has `pebble enter` as entrypoint. [Learn about
Pebble](https://github.com/canonical/pebble).

You can access the `java` with the following command:

```sh
$ docker run --rm ubuntu/jre:21_edge exec java
Usage: java [options] <mainclass> [args...]
...
```

The image supports following commands: `java`, `jfr`, `jrunscript`,
`jwebserver`, `keytool`, `rmiregistry`.

### Building and running an application on Chiselled OpenJDK 21 runtime

Let's assume, you have the following Java source code you want to run
as an application. Assume the file is called `HelloWorld.java`.

```java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello World!");
    }
}
```

The OpenJDK runtime image does not include the `javac` compiler,
so you will need to compile your class first. You may create the
following Dockerfile for your application image:

```Dockerfile
FROM ubuntu:noble-20250127 AS builder

RUN DEBIAN_FRONTEND=noninteractive apt-get install -U -y \
    default-jdk-headless

ADD HelloWorld.java /
RUN javac -d / /HelloWorld.java

FROM ubuntu/jre:21_edge

COPY --from=builder HelloWorld.class /

CMD [ "exec", "java", "-cp", "/", "HelloWorld" ]
```

Build the image:

```sh
docker build -t hello -f Dockerfile.app .
```

Run your application container:

```sh
docker run --rm hello
Hello World!
```

### Running a simple Java application without building another image

Let's assume the previous hello world example file is in the current
directory and was compiled:
```sh
javac HelloWorld.java -d .
```

 You may run the application with the Chiselled Java image as shown below:

```sh
docker run --rm -v `pwd`:/app ubuntu/jre:21_edge \
 exec java -cp /app HelloWorld
Hello World!
```

The example is available [here](../demos/helloworld/).

### Spring Petclinic

An advanced example of deploying a Spring Boot application
is available [here](../demos/petclinic/).
