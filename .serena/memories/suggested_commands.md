# Neurite 개발 명령어

## 개발 서버 실행
```bash
# 메인 애플리케이션 시작
npm start

# 호스트 바인딩으로 시작 (외부 접근 허용)
npm run start:host

# 로컬 서버들 시작
cd localhost_servers
npm run start

# 특정 서버만 시작
npm run start neurite
```

## 빌드 및 배포
```bash
# 프로덕션 빌드
npm run build

# 빌드 후 파일 복사
npm run postbuild
```

## 개발 도구
```bash
# 프로젝트 디렉토리 이동
cd C:\Users\Docker\WorkSpace\Neurite

# 파일 목록 확인
dir
ls

# 파일 검색
findstr /s "pattern" *.js
grep -r "pattern" js/

# Git 명령어
git status
git add .
git commit -m "message"
git push
```

## 테스트 및 디버깅
```bash
# 브라우저 개발자 도구에서
Logger.levelId = 'debug';  // 디버그 로그 활성화
Logger.levelId = 'info';   // 정보 로그만 표시

# 콘솔에서 테스트 함수 실행
testHierarchy(10, 1000);  // 노드 계층 구조 테스트
runToolTipTests();        // 툴팁 테스트
```

## 로컬 서버 관리
```bash
# 서버 상태 확인
netstat -an | findstr :8080

# 프로세스 종료
taskkill /f /im node.exe
```

## 파일 편집
```bash
# VS Code로 열기
code .

# 특정 파일 편집
notepad js/main.js
```

## 의존성 관리
```bash
# 패키지 설치
npm install

# 패키지 업데이트
npm update

# 패키지 제거
npm uninstall package-name
```