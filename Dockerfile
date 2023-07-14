ARG VERSION=8u151

FROM openjdk:${VERSION}-jdk as BUILD

COPY . /src
WORKDIR /src
RUN ./gradlew shadowJar --no-daemon

FROM openjdk:${VERSION}-jre

COPY --from=BUILD /src/build/libs/hello-kotlin-docker-action.jar /bin/runner/run.jar
WORKDIR /bin/runner

CMD ["java","-jar","run.jar"]