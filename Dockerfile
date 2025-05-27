# Etapa 1: Build
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Garante UTF-8 no ambiente
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Define o diretório de trabalho
WORKDIR /app

# Copia os arquivos do projeto para o contêiner
COPY . .

# Executa o build do projeto, ignorando testes
RUN mvn clean package -DskipTests

# Etapa 2: Runtime
FROM eclipse-temurin:17-jre

# Diretório de trabalho no container
WORKDIR /app

# Expõe a porta da aplicação
EXPOSE 8080

# Copia o arquivo JAR gerado na etapa de build
COPY --from=build /app/target/*.jar app.jar

# Comando de entrada para rodar a aplicação
ENTRYPOINT ["java", "-jar", "app.jar"]
