# Etapa 1: Build
FROM ubuntu:latest AS build

FROM maven:3.9.6-eclipse-temurin-17 AS build

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN apt-get update && apt-get install -y openjdk-17-jdk maven

# Define um diretório de trabalho consistente
WORKDIR /app

# Copia tudo para /app
COPY . .

# Constrói o projeto
RUN mvn clean install -DskipTests

# Etapa 2: Execução
FROM openjdk:17-jdk-slim

EXPOSE 8080

# Copia o .jar gerado do diretório correto
COPY --from=build /app/target/*.jar app.jar

ENTRYPOINT [ "java", "-jar", "app.jar" ]