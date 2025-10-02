# Neurite 프로젝트 개요

## 프로젝트 목적
**Neurite**는 프랙탈 기반의 마인드 매핑 및 AI 에이전트 협업 플랫폼입니다. Mandelbrot 집합을 실시간으로 탐색하면서 노드 기반의 지식 관리 시스템을 제공합니다.

## 핵심 기능
1. **프랙탈 네비게이션**: 실시간 Mandelbrot 집합 탐색 및 커스터마이징
2. **멀티 에이전트 UI**: 여러 AI 노드 간의 협업 네트워크 구축
3. **FractalGPT**: 그래프 기반 AI 대화 시스템
4. **동기화된 지식 관리**: 마인드맵과 Zettelkasten 간 양방향 동기화
5. **Neural API**: 프로그래밍 가능한 함수 호출 시스템
6. **물리 기반 시뮬레이션**: 노드들의 물리적 상호작용

## 기술 스택
- **Frontend**: Vanilla JavaScript (ES6+), HTML5, CSS3
- **Build Tool**: Vite 6.1.1
- **Code Editor**: CodeMirror 5
- **AI Integration**: OpenAI, Anthropic, Groq, Ollama
- **External APIs**: Wolfram Alpha, Wikipedia
- **Local Storage**: LocalForage
- **PDF Processing**: PDF.js
- **Desktop**: Electron (Windows, macOS, Linux)

## 프로젝트 구조
```
Neurite/
├── js/                    # 핵심 JavaScript 모듈
│   ├── main.js           # 애플리케이션 진입점
│   ├── ai/               # AI 관련 기능
│   ├── interface/        # UI 인터페이스
│   ├── nodes/            # 노드 시스템
│   ├── mandelbrot/       # 프랙탈 렌더링
│   └── zettelkasten/     # 노트 시스템
├── resources/            # HTML 템플릿 및 스타일
├── localhost_servers/    # 로컬 서버들
└── wiki/                # 프로젝트 문서
```

## 주요 컴포넌트
1. **App 클래스**: 메인 애플리케이션 관리
2. **NodeSimulation**: 물리 기반 노드 시뮬레이션
3. **Fractal**: Mandelbrot 집합 렌더링
4. **AI 시스템**: 다양한 AI 모델 통합
5. **Zettelkasten**: 노트 관리 시스템
6. **Neural API**: 함수 호출 시스템