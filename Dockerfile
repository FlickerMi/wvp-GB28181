FROM openjdk:8-jdk-alpine
VOLUME /tmp
ARG JAR_FILE
ADD target/${JAR_FILE} app.jar

RUN echo -e "Asia/Shanghai" > /etc/timezone

ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/app.jar", "--spring.config.location=/config/"]
