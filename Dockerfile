# 1) 빌드/런타임 통합(간단)
FROM node:20-alpine

# 보안/재현성을 위해 고정 작업 디렉토리
WORKDIR /app

# 의존성만 먼저 복사해 캐시 활용 (있으면)
COPY package*.json ./

# 프로덕션 의존성만 설치
RUN npm ci --omit=dev || npm i --only=production

# 애플리케이션 소스 복사
COPY . .

# 컨테이너 내부 포트(문서화 목적) – 실행 시에는 $PORT 사용
EXPOSE 8080

# 플랫폼이 주입하는 PORT 환경변수 사용
ENV NODE_ENV=production
ENTRYPOINT ["node", "server.js"]
