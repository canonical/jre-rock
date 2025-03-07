# Chiselled OpenJDK 21

This directory contains the image recipes of Chiselled OpenJDK 21. These
images are smaller in size and, therefore less prone to vulnerabilities. Know
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
 docker-daemon:ubuntu/jdk:21_edge
```

The image has `pebble enter` as the entrypoint. [Learn about
Pebble](https://github.com/canonical/pebble).

You can access the `java` with the following command:

```sh
$ docker run --rm ubuntu/jdk:21_edge exec java
Usage: java [options] <mainclass> [args...]
...
```
