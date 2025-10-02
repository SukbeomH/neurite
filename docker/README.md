# 🐳 Neurite Docker 구성

이 디렉토리는 Neurite의 Docker 배포를 위한 모든 설정 파일을 포함합니다.

## 📁 디렉토리 구조

```
docker/
├── frontend/
│   └── Dockerfile          # 프론트엔드 Docker 이미지
├── backend/
│   └── Dockerfile          # 백엔드 Docker 이미지
├── nginx/
│   └── nginx.conf          # Nginx 리버스 프록시 설정
└── scripts/
    ├── backup.sh           # 백업 스크립트
    └── health-check.sh     # 헬스체크 스크립트
```

## 🚀 빠른 시작

### 1. 기본 실행
```bash
# 개발 환경
docker-compose up -d

# 프로덕션 환경
docker-compose -f docker-compose.prod.yml up -d
```

### 2. 서비스 확인
```bash
# 서비스 상태 확인
docker-compose ps

# 로그 확인
docker-compose logs -f
```

## 📋 서비스 구성

### 프론트엔드 (neurite-frontend)
- **포트**: 8080
- **기반**: Node.js 18 + Nginx
- **기능**: Vite 개발 서버, 정적 파일 서빙

### 백엔드 (neurite-backend)
- **포트**: 7070
- **기반**: Node.js 18 + Express
- **기능**: AI 프록시, 웹 스크래핑, 자동화

### 프록시 (neurite-proxy)
- **포트**: 80, 443
- **기반**: Nginx Alpine
- **기능**: 리버스 프록시, SSL 종료, 로드 밸런싱

## 🔧 설정 파일

### Docker Compose
- `docker-compose.yml`: 개발 환경 설정
- `docker-compose.prod.yml`: 프로덕션 환경 설정

### 환경 변수
- `env.example`: 환경 변수 템플릿
- `.env`: 실제 환경 변수 (생성 필요)

### Docker 설정
- `.dockerignore`: Docker 빌드 컨텍스트 최적화
- `Dockerfile`: 멀티 스테이지 빌드 구성

## 📊 모니터링

### 헬스체크
```bash
# 전체 서비스 헬스체크
docker-compose exec neurite-backend /app/scripts/health-check.sh
```

### 로그 모니터링
```bash
# 실시간 로그
docker-compose logs -f

# 특정 서비스 로그
docker-compose logs -f neurite-frontend
```

## 🔄 백업 및 복원

### 자동 백업
```bash
# 백업 실행
docker-compose exec neurite-backend /app/scripts/backup.sh
```

### 수동 백업
```bash
# 데이터 볼륨 백업
docker run --rm -v neurite_data:/data -v $(pwd):/backup alpine tar czf /backup/neurite-backup.tar.gz -C /data .
```

## 🚨 문제 해결

### 일반적인 문제

#### 1. 포트 충돌
```bash
# 포트 사용 확인
netstat -tulpn | grep :8080
netstat -tulpn | grep :7070
```

#### 2. 메모리 부족
```bash
# 메모리 사용량 확인
docker stats
```

#### 3. 권한 문제
```bash
# 볼륨 권한 확인
docker-compose exec neurite-backend ls -la /app/data/
```

### 로그 분석

#### 프론트엔드 오류
```bash
docker-compose logs neurite-frontend | grep -i error
```

#### 백엔드 오류
```bash
docker-compose logs neurite-backend | grep -i error
```

## 📈 성능 최적화

### 1. 이미지 최적화
- 멀티 스테이지 빌드 사용
- Alpine Linux 기반 이미지
- 불필요한 파일 제거

### 2. 리소스 제한
```yaml
deploy:
  resources:
    limits:
      memory: 512M
      cpus: '0.5'
```

### 3. 캐싱 최적화
- Nginx 정적 파일 캐싱
- Redis 캐시 레이어 (선택사항)

## 🔒 보안 설정

### 1. 비루트 사용자
```dockerfile
# Dockerfile에서 비루트 사용자 설정
USER neurite
```

### 2. 환경 변수 보안
```bash
# .env 파일 보안
chmod 600 .env
```

### 3. 네트워크 격리
```yaml
# 내부 네트워크 사용
networks:
  neurite-network:
    driver: bridge
```

## 📚 추가 리소스

- [Docker 공식 문서](https://docs.docker.com/)
- [Docker Compose 문서](https://docs.docker.com/compose/)
- [Nginx 설정 가이드](https://nginx.org/en/docs/)
- [Neurite 메인 문서](../README.md)

## 🆘 지원

문제가 발생하면:

1. **로그 확인**: `docker-compose logs`
2. **헬스체크**: `docker-compose exec neurite-backend /app/scripts/health-check.sh`
3. **GitHub Issues**: [Neurite Issues](https://github.com/satellitecomponent/Neurite/issues)
