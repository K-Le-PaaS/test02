# Multi-stage build for Java application
FROM gradle:8.5-amazoncorretto-17 AS builder

# 작업 디렉토리 설정
WORKDIR /app

# Gradle 설정 파일 복사
COPY build.gradle settings.gradle ./
COPY src ./src

# 애플리케이션 빌드
RUN gradle bootJar --no-daemon

# 런타임 이미지
FROM eclipse-temurin:17-jre

# 작업 디렉토리 설정
WORKDIR /app

# 빌드된 JAR 파일 복사
COPY --from=builder /app/build/libs/*.jar app.jar

# 컨테이너 내부 포트(문서화 목적) – 실행 시에는 $PORT 사용
EXPOSE 8080

# 플랫폼이 주입하는 PORT 환경변수 사용
ENV JAVA_OPTS=""
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
