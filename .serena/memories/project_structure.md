# Neurite 프로젝트 구조

## 핵심 디렉토리

### `/js/` - 메인 JavaScript 모듈
- **`main.js`**: 애플리케이션 진입점, 전역 클래스 정의
- **`globals.js`**: 전역 유틸리티 및 설정
- **`ai/`**: AI 관련 기능
  - `ai_v2.js`: AI API 호출
  - `ollama/`: 로컬 AI 모델
  - `ai-utility/`: AI 헬퍼 함수
- **`interface/`**: UI 인터페이스
  - `dropdown/`: 드롭다운 메뉴
  - `functioncall/`: 함수 호출 패널
  - `searchapi/`: 검색 API
- **`nodes/`**: 노드 시스템
  - `nodeclass.js`: 기본 노드 클래스
  - `nodetypes/`: 다양한 노드 타입
  - `nodeinteraction/`: 노드 상호작용
- **`mandelbrot/`**: 프랙탈 렌더링
- **`zettelkasten/`**: 노트 시스템

### `/resources/` - 정적 리소스
- **`html/`**: HTML 템플릿
- **`styles/`**: CSS 스타일
- **`svg/`**: SVG 아이콘

### `/localhost_servers/` - 로컬 서버들
- **`ai-proxy/`**: AI 프록시 서버
- **`automation/`**: 자동화 서버
- **`webscrape/`**: 웹 스크래핑 서버
- **`wiki-search/`**: 위키 검색 서버
- **`wolfram-alpha/`**: Wolfram Alpha 서버

### `/wiki/` - 프로젝트 문서
- **`pages/`**: 위키 페이지들
- **`css/`**: 위키 스타일

## 주요 파일

### 설정 파일
- **`package.json`**: 프로젝트 설정 및 의존성
- **`vite.config.js`**: Vite 빌드 설정
- **`index.html`**: 메인 HTML 파일

### 문서
- **`README.md`**: 프로젝트 설명서
- **`LICENSE`**: MIT 라이선스

## 모듈 로딩 순서

1. **`js/main.js`**: 전역 클래스 및 유틸리티
2. **`js/globals.js`**: 전역 설정
3. **인터페이스 모듈들**: UI 컴포넌트
4. **노드 시스템**: 노드 관련 기능
5. **AI 시스템**: AI 통합
6. **프랙탈 시스템**: 렌더링 엔진

## 의존성 관계

```
main.js
├── globals.js
├── interface/
│   ├── dropdown/
│   ├── functioncall/
│   └── searchapi/
├── nodes/
│   ├── nodeclass.js
│   ├── nodetypes/
│   └── nodeinteraction/
├── ai/
│   ├── ai_v2.js
│   └── ollama/
├── mandelbrot/
└── zettelkasten/
```

## 빌드 프로세스

1. **Vite**: ES6+ 모듈을 번들링
2. **Post-build**: `js/`, `resources/`, `wiki/` 디렉토리를 `dist/`로 복사
3. **Electron**: 데스크톱 앱 빌드 (선택사항)