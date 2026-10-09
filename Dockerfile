# Build with Java 17 and Maven
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn -B -DskipTests clean package

# Small Java 17 runtime image
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/*.jar /app/app.jar
EXPOSE 10000
# Render supplies PORT. Fall back to 10000 for platforms that do not.
CMD ["sh", "-c", "exec java ${JAVA_OPTS:-} -Dserver.port=${PORT:-10000} -jar /app/app.jar"]
