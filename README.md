# OpenTelemetry-PetClinic

Just the [Spring PetClinic](https://github.com/spring-petclinic/spring-framework-petclinic) sample application image with [OpenTelemetry Java Instrumentation](https://github.com/open-telemetry/opentelemetry-java-instrumentation) agent inside. 

Current OpenTelemetry Java agent version: `v1.11.1`

## Prerequisites

* [Sumo Logic HTTP Traces URL](https://help.sumologic.com/Traces/01Getting_Started_with_Transaction_Tracing/HTTP_Traces_Source)
* Docker

## Run

Run docker with auto-instrumented PetClinic application.

```bash
export TRACES_URL=YOUR SUMO LOGIC HTTP TRACES URL

docker run --rm --name ot-petclinic -p 8080:8080 \
    --env JAVA_TOOL_OPTIONS="-javaagent:/agent/opentelemetry-javaagent.jar" \
    --env OTEL_SERVICE_NAME=petclinic-svc \
    --env OTEL_RESOURCE_ATTRIBUTES=application=petclinic-app \
    --env OTEL_EXPORTER_OTLP_TRACES_ENDPOINT=${TRACES_URL} \
    --env OTEL_EXPORTER_OTLP_TRACES_PROTOCOL=http/protobuf \
    public.ecr.aws/sumologic/opentelemetry-petclinic:latest
```

Navigate to http://localhost:8080 and play with app. Search for traces by `service.name=petclinic-svc`

For instrumentation details please visit: [Sumo Logic OpenTelemetry Java auto-instrumentation](https://help.sumologic.com/Traces/01Getting_Started_with_Transaction_Tracing/Instrument_your_application_with_OpenTelemetry/Java_OpenTelemetry_auto-instrumentation) guide.

## Local build

```bash
docker build -t opentelemetry-petclinic .
```
