# 🐳 Neurite Docker 배포 가이드

Neurite를 Docker로 배포하는 완전한 가이드입니다.

## 📋 목차

- [시스템 요구사항](#시스템-요구사항)
- [빠른 시작](#빠른-시작)
- [상세 설정](#상세-설정)
- [프로덕션 배포](#프로덕션-배포)
- [모니터링 및 유지보수](#모니터링-및-유지보수)
- [문제 해결](#문제-해결)

## 🖥️ 시스템 요구사항

### 최소 요구사항
- **CPU**: 2코어
- **RAM**: 4GB
- **Storage**: 10GB
- **OS**: Linux, macOS, Windows (Docker 지원)

### 권장 요구사항
- **CPU**: 4코어 이상
- **RAM**: 8GB 이상
- **Storage**: 50GB 이상
- **Network**: 안정적인 인터넷 연결

## 🚀 빠른 시작

### 1. 프로젝트 클론
```bash
git clone https://github.com/satellitecomponent/Neurite.git
cd Neurite
```

### 2. 환경 설정
```bash
# 환경 변수 파일 복사
cp env.example .env

# 환경 변수 편집 (필요시)
nano .env
```

### 3. Docker 빌드 및 실행
```bash
# 개발 환경 실행
docker-compose up -d

# 프로덕션 환경 실행
docker-compose -f docker-compose.prod.yml up -d
```

### 4. 접속 확인
- **프론트엔드**: http://localhost:8080
- **백엔드 API**: http://localhost:7070

## ⚙️ 상세 설정

### Docker Compose 구성

#### 개발 환경 (`docker-compose.yml`)
```yaml
services:
  neurite-frontend:    # Vite 개발 서버
  neurite-backend:     # Express 마이크로서비스
  neurite-proxy:       # Nginx 리버스 프록시 (선택사항)
```

#### 프로덕션 환경 (`docker-compose.prod.yml`)
```yaml
services:
  neurite-frontend:    # 최적화된 프론트엔드
  neurite-backend:     # 프로덕션 백엔드
  neurite-proxy:       # SSL 지원 Nginx
  neurite-redis:       # 캐싱 레이어 (선택사항)
```

### 환경 변수 설정

#### 필수 설정
```bash
# 애플리케이션 환경
NODE_ENV=production
PORT=8080
BACKEND_PORT=7070

# 보안
JWT_SECRET=your-secure-jwt-secret
API_KEY=your-api-key
```

#### AI 서비스 설정
```bash
# OpenAI
OPENAI_API_KEY=sk-your-openai-key

# Anthropic
ANTHROPIC_API_KEY=your-anthropic-key

# Groq
GROQ_API_KEY=your-groq-key
```

#### 외부 서비스 설정
```bash
# Wolfram Alpha
WOLFRAM_APP_ID=your-wolfram-app-id

# Wikipedia API
WIKIPEDIA_API_URL=https://en.wikipedia.org/api/rest_v1
```

## 🏭 프로덕션 배포

### 1. SSL 인증서 설정
```bash
# Let's Encrypt 사용
mkdir -p docker/nginx/ssl
certbot certonly --standalone -d yourdomain.com
cp /etc/letsencrypt/live/yourdomain.com/fullchain.pem docker/nginx/ssl/cert.pem
cp /etc/letsencrypt/live/yourdomain.com/privkey.pem docker/nginx/ssl/key.pem
```

### 2. 프로덕션 실행
```bash
# 프로덕션 모드 실행
docker-compose -f docker-compose.prod.yml up -d

# 로그 확인
docker-compose -f docker-compose.prod.yml logs -f
```

### 3. 자동 시작 설정
```bash
# systemd 서비스 생성
sudo tee /etc/systemd/system/neurite.service > /dev/null <<EOF
[Unit]
Description=Neurite Docker Service
Requires=docker.service
After=docker.service

[Service]
Type=oneshot
RemainAfterExit=yes
WorkingDirectory=/path/to/Neurite
ExecStart=/usr/bin/docker-compose -f docker-compose.prod.yml up -d
ExecStop=/usr/bin/docker-compose -f docker-compose.prod.yml down

[Install]
WantedBy=multi-user.target
EOF

# 서비스 활성화
sudo systemctl enable neurite.service
sudo systemctl start neurite.service
```

## 📊 모니터링 및 유지보수

### 헬스체크
```bash
# 컨테이너 상태 확인
docker-compose ps

# 헬스체크 실행
docker-compose exec neurite-backend /app/scripts/health-check.sh
```

### 로그 모니터링
```bash
# 실시간 로그 확인
docker-compose logs -f

# 특정 서비스 로그
docker-compose logs -f neurite-frontend
docker-compose logs -f neurite-backend
```

### 백업 및 복원
```bash
# 백업 실행
docker-compose exec neurite-backend /app/scripts/backup.sh

# 백업 파일 확인
ls -la /app/backups/

# 복원 (필요시)
tar -xzf /app/backups/neurite-backup-YYYYMMDD-HHMMSS.tar.gz -C /app/data/
```

### 업데이트
```bash
# 최신 코드 가져오기
git pull origin main

# 이미지 재빌드
docker-compose build --no-cache

# 서비스 재시작
docker-compose up -d
```

## 🔧 문제 해결

### 일반적인 문제

#### 1. 포트 충돌
```bash
# 사용 중인 포트 확인
netstat -tulpn | grep :8080
netstat -tulpn | grep :7070

# 포트 변경 (docker-compose.yml)
ports:
  - "8081:80"  # 8080 대신 8081 사용
```

#### 2. 메모리 부족
```bash
# 메모리 사용량 확인
docker stats

# 메모리 제한 설정
deploy:
  resources:
    limits:
      memory: 512M
```

#### 3. 데이터베이스 연결 오류
```bash
# 데이터베이스 파일 권한 확인
ls -la /app/data/

# 권한 수정
chmod 644 /app/data/neurite.db
```

### 로그 분석

#### 프론트엔드 오류
```bash
# Vite 빌드 오류 확인
docker-compose logs neurite-frontend | grep -i error
```

#### 백엔드 오류
```bash
# Express 서버 오류 확인
docker-compose logs neurite-backend | grep -i error
```

#### 데이터베이스 오류
```bash
# SQLite 오류 확인
docker-compose logs neurite-backend | grep -i sqlite
```

### 성능 최적화

#### 1. 이미지 크기 최적화
```dockerfile
# 멀티 스테이지 빌드 사용
FROM node:18-alpine AS builder
# ... 빌드 단계
FROM nginx:alpine AS production
# ... 프로덕션 단계
```

#### 2. 캐싱 최적화
```yaml
# Redis 캐시 사용
services:
  neurite-redis:
    image: redis:7-alpine
    volumes:
      - neurite-redis:/data
```

#### 3. 네트워크 최적화
```yaml
# 네트워크 설정
networks:
  neurite-network:
    driver: bridge
    ipam:
      config:
        - subnet: 172.20.0.0/16
```

## 📚 추가 리소스

### 유용한 명령어
```bash
# 컨테이너 재시작
docker-compose restart

# 특정 서비스 재시작
docker-compose restart neurite-frontend

# 볼륨 확인
docker volume ls

# 네트워크 확인
docker network ls
```

### 모니터링 도구
- **Prometheus + Grafana**: 메트릭 수집 및 시각화
- **ELK Stack**: 로그 수집 및 분석
- **Portainer**: Docker 관리 UI

### 보안 체크리스트
- [ ] 환경 변수 보안 설정
- [ ] SSL 인증서 구성
- [ ] 방화벽 설정
- [ ] 정기적인 보안 업데이트
- [ ] 백업 전략 수립

## 🆘 지원

문제가 발생하면 다음을 확인하세요:

1. **로그 확인**: `docker-compose logs`
2. **헬스체크**: `docker-compose exec neurite-backend /app/scripts/health-check.sh`
3. **시스템 리소스**: `docker stats`
4. **네트워크 연결**: `docker network inspect neurite-network`

추가 도움이 필요하면 [GitHub Issues](https://github.com/satellitecomponent/Neurite/issues)에 문의하세요.
