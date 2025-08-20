# Etapa 1: Build do projeto
FROM eclipse-temurin:21-jdk AS build
WORKDIR /app

# Copia arquivos do projeto
COPY . .

# Dá permissão de execução para o Maven Wrapper (caso exista)
RUN chmod +x mvnw

# Compila e empacota a aplicação (sem rodar testes)
RUN ./mvnw clean package -DskipTests

# Etapa 2: Imagem final de execução
FROM eclipse-temurin:21-jdk
WORKDIR /app

# Copia o JAR gerado da etapa de build
COPY --from=build /app/target/*.jar app.jar

# Comando para rodar o app
ENTRYPOINT ["java","-jar","app.jar"]
