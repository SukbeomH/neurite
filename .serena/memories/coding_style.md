# Neurite 코딩 스타일 및 컨벤션

## JavaScript 스타일
- **ES6+ 모듈**: `import/export` 사용
- **클래스 기반**: 객체지향 프로그래밍
- **화살표 함수**: 간단한 함수에서 사용
- **const/let**: var 사용 금지
- **템플릿 리터럴**: 문자열 보간

## 네이밍 컨벤션
- **클래스**: PascalCase (예: `NodeClass`, `App`)
- **함수/변수**: camelCase (예: `createNode`, `nodeSimulation`)
- **상수**: UPPER_SNAKE_CASE (예: `DRAG_THRESHOLD`)
- **프라이빗 필드**: `#` 접두사 (예: `#privateField`)

## 로깅 시스템
```javascript
Logger.info("정보 메시지");
Logger.warn("경고 메시지");
Logger.error("에러 메시지");
Logger.debug("디버그 메시지");
```

## 이벤트 처리
```javascript
On.click(element, handler);
Off.click(element, handler);
```

## DOM 조작
```javascript
Elem.byId(id);           // getElementById
Elem.hide(element);      // display: none
Elem.displayBlock(element); // display: block
```

## 비동기 처리
- **async/await**: Promise 대신 사용
- **Promise.delay()**: 지연 실행
- **Request.send()**: HTTP 요청

## 코멘트 스타일
- **TODO**: `// TODO: 설명`
- **FIXME**: `// FIXME: 설명`
- **NOTE**: `// NOTE: 설명`

## 모듈 구조
- **정적 메서드**: 클래스 내부에서 정의
- **인스턴스 메서드**: 프로토타입에 정의
- **유틸리티 함수**: 전역 함수로 정의