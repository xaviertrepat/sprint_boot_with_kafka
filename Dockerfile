## SPRING BOOT BUILD
FROM gradle:6.0.1-jdk8 as compile
WORKDIR /home/source/sprint_boot_with_kafka
COPY . /home/source/sprint_boot_with_kafka

USER root
RUN chown -R gradle /home/source/sprint_boot_with_kafka
USER gradle
RUN gradle clean build -x test

## SPRING BOOT RUN
FROM openjdk:8-jre-alpine as kafka_publisher
WORKDIR /home/application/java
COPY --from=compile "/home/source/sprint_boot_with_kafka/build/libs/sprint_boot_with_kafka-0.0.1-SNAPSHOT.jar" .
EXPOSE 8080
RUN apk --no-cache add curl
ENTRYPOINT ["java", "-jar", "/home/application/java/sprint_boot_with_kafka-0.0.1-SNAPSHOT.jar"]

#HEALTHCHECK CMD curl --fail http://localhost:8080/actuator-admin/health || exit 1