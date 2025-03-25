# Spring PetClinic

This Dockerfile runs the [Spring PetClinic](https://github.com/spring-projects/spring-petclinic) sample on the `ubuntu/jre` container image.

# Running the sample

Execute:

`` docker build -t petclinic . && docker run -p 8080:8080 --tmpfs /tmp:exec petclinic ``

Give it a few minutes to build the sample application and then navigate to http://localhost:8080 to explore the demo.

# Health check

`ubuntu/jre` rock includes [pebble](https://documentation.ubuntu.com/pebble/)
service manager. The sample configures a [health check](./001-spring-petclinic.yaml) to restart Spring Petclinic.

Run the container:

```bash

docker run -d --name petclinic -p 8080:8080 --tmpfs /tmp:exec petclinic

```

Check the service health:

```bash

docker exec petclinic pebble checks

```

This prints the status of the service:

```

Check            Level  Status  Failures  Change
check-petclinic  -      up      0/3       1

```
