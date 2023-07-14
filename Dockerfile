ARG VERSION=8u151

FROM openjdk:${VERSION}-jdk as BUILD

WORKDIR /src
COPY . /src

RUN ./gradlew shadowJar --no-daemon

FROM openjdk:${VERSION}-jre

WORKDIR /bin/runner
COPY --from=BUILD /src/build/libs/hello-kotlin-docker-action.jar /bin/runner/run.jar

ENTRYPOINT ["java", "-jar", "/bin/runner/run.jar"]