# Neurite 작업 완료 체크리스트

## 코드 수정 후 필수 확인사항

### 1. 빌드 테스트
```bash
npm run build
```
- 빌드 오류가 없는지 확인
- 모든 모듈이 정상적으로 로드되는지 확인

### 2. 개발 서버 실행 테스트
```bash
npm start
```
- 브라우저에서 http://localhost:8080 접속
- 콘솔에 오류가 없는지 확인
- 주요 기능이 정상 작동하는지 확인

### 3. 로그 레벨 확인
```javascript
// 브라우저 콘솔에서
Logger.levelId = 'debug';  // 모든 로그 확인
Logger.levelId = 'info';   // 일반 로그만 확인
```

### 4. 기능별 테스트
- **노드 생성**: Shift + 더블클릭으로 텍스트 노드 생성
- **AI 노드**: Alt + 더블클릭으로 AI 노드 생성
- **프랙탈 탐색**: 마우스 휠로 줌, 드래그로 이동
- **노드 연결**: Shift + 클릭으로 노드 연결
- **Zettelkasten**: 노트 탭에서 텍스트 편집

### 5. 로컬 서버 테스트
```bash
cd localhost_servers
npm run start
```
- 모든 서버가 정상적으로 시작되는지 확인
- API 엔드포인트가 응답하는지 확인

### 6. 코드 품질 확인
- **ESLint**: 코드 스타일 검사 (설정된 경우)
- **콘솔 오류**: 브라우저 개발자 도구에서 오류 확인
- **메모리 누수**: 장시간 사용 후 성능 확인

### 7. Git 커밋 전 확인
```bash
git status
git diff
git add .
git commit -m "설명적인 커밋 메시지"
```

## 문제 해결 체크리스트

### 빌드 실패 시
1. `node_modules` 삭제 후 `npm install` 재실행
2. Vite 캐시 클리어: `npm run build -- --force`
3. Node.js 버전 확인 (권장: 18+)

### 개발 서버 오류 시
1. 포트 8080이 사용 중인지 확인
2. 방화벽 설정 확인
3. 다른 포트로 실행: `npm run start:host -- --port 3000`

### 로컬 서버 오류 시
1. 의존성 설치: `cd localhost_servers && npm install`
2. 포트 충돌 확인
3. 서버 로그 확인

### AI 기능 오류 시
1. API 키 설정 확인
2. 네트워크 연결 확인
3. 브라우저 콘솔에서 오류 메시지 확인