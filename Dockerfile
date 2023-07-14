FROM openjdk:8-jdk-alpine as BUILD

COPY . /src
WORKDIR /src
RUN ./gradlew shadowJar --no-daemon

FROM openjdk:8-jre-alpine

COPY --from=BUILD /src/build/libs/hello-kotlin-docker-action.jar /bin/runner/run.jar
WORKDIR /bin/runner

CMD ["java","-jar","run.jar"]