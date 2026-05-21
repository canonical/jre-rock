# Chiselled OpenJDK 11

This directory contains the image recipes of Chiselled OpenJDK 11. These
images are smaller in size and, therefore less prone to vulnerabilities. Know
more about chisel [here](https://github.com/canonical/chisel).

We currently have Chiselled OpenJDK 11 on Noble. See
[rockcraft.yaml](./ockcraft.yaml).

### Building the image(s)

Build the rock in the usual way:

```sh
rockcraft pack
```

### Running the image(s)

Import the recently created rock into Docker using
[skopeo](https://github.com/containers/skopeo).

```sh
$ rockcraft.skopeo copy \
 oci-archive:jre_11-edge_amd64.rock \
 docker-daemon:ubuntu/jre:11_edge
```

The image has `pebble enter` as the entrypoint. [Learn about
Pebble](https://github.com/canonical/pebble).

You can access the `java` with the following command:

```sh
$ docker run --rm ubuntu/jre:11_edge exec java
Usage: java [options] <mainclass> [args...]
...
```

The image supports the following commands: `java`, `jfr`, `jrunscript`,
`jwebserver`, `keytool`, `rmiregistry`.

### Building and running an application on Chiselled OpenJDK 11 runtime

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
so you should compile your class first. You may create the
following Dockerfile for your application image:

```Dockerfile
FROM ubuntu:noble-20250127 AS builder

RUN DEBIAN_FRONTEND=noninteractive apt-get install -U -y \
    default-jdk-headless

ADD HelloWorld.java /
RUN javac -d / /HelloWorld.java

FROM ubuntu/jre:11_edge

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

Let's assume the previous Hello World example file is in the current
directory and was compiled:
```sh
javac HelloWorld.java -d .
```

 You may run the application with the Chiselled Java image as shown below:

```sh
docker run --rm -v `pwd`:/app ubuntu/jre:11_edge \
 exec java -cp /app HelloWorld
Hello World!
```

The example is available [here](../../demos/11-jre-24.04/helloworld/).

### Spring Petclinic

An advanced example of deploying a Spring Boot application
is available [here](../../demos/11-jre-24.04/petclinic/).
