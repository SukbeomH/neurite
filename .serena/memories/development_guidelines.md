# Neurite 개발 가이드라인

## 개발 원칙

### 1. 단순함 우선 (Simplicity First)
- **작동하는 것이 완벽함보다 낫다**
- **필요한 것만 구현**
- **복잡한 구조보다 단순한 구조**
- **올바른 main.py 로직 우선**

### 2. 함수 기반 구조
- 클래스보다 함수를 선호
- 단일 책임 원칙 준수
- 명확한 함수명 사용

### 3. 최소한의 설정
- 과도한 CLI 옵션 금지
- 복잡한 설정 시스템 지양
- 불필요한 모듈화 방지

## 금지 사항

### ❌ 피해야 할 것들
- 과도한 CLI 옵션
- 복잡한 설정 시스템
- 불필요한 모듈화
- 임시 디렉토리 관리
- 배치 처리 복잡성
- 과도한 클래스 구조
- 복잡한 에러 처리 패턴

### ❌ 코딩 금지사항
- `var` 사용 (const/let 사용)
- 전역 변수 남용
- 하드코딩된 값
- 복잡한 중첩 구조
- 불필요한 주석

## 권장사항

### ✅ 좋은 코딩 패턴
```javascript
// 함수 기반 구조
function processBook(bookDir) {
    try {
        // 핵심 로직
        return true;
    } catch (error) {
        Logger.error(`처리 실패: ${error}`);
        return false;
    }
}

// 단순한 설정
const config = {
    outputDirectory: "Ridibooks_Processed",
    filenamePattern: "[{author}] {title}",
    metadataCache: true
};

// 직접적인 처리 방식
function processDirectory(inputDir) {
    for (const bookDir of findBookDirectories(inputDir)) {
        processBook(bookDir);
    }
    moveToFinalLocation(inputDir);
}
```

### ✅ 에러 처리
```javascript
// 단순한 에러 처리
try {
    const result = doSomething();
    return result;
} catch (error) {
    Logger.error(`실패: ${error}`);
    return null;
}
```

## 워크플로우

### 1. 올바른 main.py 방식 우선
- 핵심 로직을 main.js에서 가져옴
- 검증된 방식 사용
- 새로운 패턴 도입 시 신중하게

### 2. 단순한 워크플로우 (6단계)
1. DRM 제거 (올바른 main.py 방식)
2. 메타데이터 수집 (API 호출)
3. 자동 변환 (만화책만 CBZ)
4. 파일명 변경 (메타데이터 기반)
5. 최종 이동 (상위 디렉토리)
6. 완료

### 3. 직접적인 CLI
```javascript
// 단순한 CLI (단일 명령어)
function main() {
    const parser = new ArgumentParser();
    parser.addArgument("input_directory", { help: "입력 디렉토리" });
    parser.addArgument("--no-recursive", { action: "store_true", help: "재귀 처리 비활성화" });
    
    const args = parser.parseArgs();
    
    if (args.no_recursive) {
        processSingleDirectory(args.input_directory);
    } else {
        processDirectoryRecursive(args.input_directory);
    }
}
```

## 코딩 스타일

### 함수 작성
```javascript
function functionName(param) {
    /**
     * 간단한 설명
     * 
     * @param {string} param - 매개변수 설명
     * @returns {boolean} 반환값 설명
     */
    try {
        // 핵심 로직만
        return true;
    } catch (error) {
        Logger.error(`에러: ${error}`);
        return false;
    }
}
```

### 변수명 및 함수명
```javascript
// 영어 변수명, 한국어 주석
const bookMetadata = getBookInfo(bookId);  // 도서 메타데이터 가져오기
const decryptedContent = decryptFile(filePath);  // 파일 복호화

// 함수명은 동사형
function processBook() {}
function getMetadata() {}
function decryptFile() {}
```

## 최종 목표

### 핵심 목표
```
단일 디렉토리를 입력받으면
├── 각 하위 디렉토리의 도서를
├── 복호화 (DRM 제거)
├── 메타데이터 적용
├── 파일 변환 (만화책만 CBZ로)
└── 입력받은 디렉토리 상위에 새로운 디렉토리 생성해서 최종 결과 저장
```

### 구현 원칙
1. **올바른 main.py 로직 그대로 사용**
2. **함수 기반 구조**
3. **최소한의 설정**
4. **직접적인 처리 방식**
5. **단순한 CLI 인터페이스**

**핵심 메시지**: 복잡한 기능보다는 **작동하는 단순한 도구**가 더 가치 있습니다.