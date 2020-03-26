FROM openjdk:11
VOLUME /tmp

COPY /target/monolithstarter-*.jar monolithstarter.jar

ENTRYPOINT java -javaagent:/newrelic/newrelic.jar -jar /monolithstarter.jar

EXPOSE 8080
