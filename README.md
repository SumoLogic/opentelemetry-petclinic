# OpenTelemetry-PetClinic

Just the [Spring PetClinic](https://github.com/spring-petclinic/spring-framework-petclinic) sample application image with [OpenTelemetry Java Instrumentation](https://github.com/open-telemetry/opentelemetry-java-instrumentation) agent inside. 

Current OpenTelemetry Java agent version: `v1.26.0`

## Prerequisites

* [Sumo Logic OTLP Endpoint URL](https://help.sumologic.com/docs/send-data/hosted-collectors/http-source/otlp/)
* Docker

## Run

Run docker with auto-instrumented PetClinic application.

```bash
export OTLP_ENDPOINT_URL=YOUR SUMO LOGIC OTLP ENDPOINT URL

docker run --rm --name ot-petclinic -p 8080:8080 \
    --env JAVA_TOOL_OPTIONS="-javaagent:/agent/opentelemetry-javaagent.jar" \
    --env OTEL_SERVICE_NAME=petclinic-svc \
    --env OTEL_RESOURCE_ATTRIBUTES=application=petclinic-app \
    --env OTEL_METRICS_EXPORTER=otlp \
    --env OTEL_TRACES_EXPORTER=otlp \
    --env OTEL_EXPORTER_OTLP_ENDPOINT=${OTLP_ENDPOINT_URL} \
    --env OTEL_EXPORTER_OTLP_PROTOCOL=http/protobuf \
    public.ecr.aws/sumologic/opentelemetry-petclinic:latest
```

Navigate to http://localhost:8080 and play with app. Search for traces by `service.name=petclinic-svc`

For instrumentation details please visit: [Sumo Logic OpenTelemetry Java auto-instrumentation](https://help.sumologic.com/docs/apm/traces/get-started-transaction-tracing/opentelemetry-instrumentation/java/) guide.

## Local build

```bash
docker build -t opentelemetry-petclinic .
```
