FROM openjdk:8-alpine

COPY target/uberjar/satisfactory.jar /satisfactory/app.jar

EXPOSE 3000

CMD ["java", "-jar", "/satisfactory/app.jar"]
