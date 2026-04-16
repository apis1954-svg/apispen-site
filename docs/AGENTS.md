# AGENTS.md — APIS 하네스엔지니어링 AI 운영 규칙 v2.0

> **이 파일은 Claude, Cursor, Copilot 등 모든 AI 에이전트가 이 저장소에서 작업할 때 반드시 먼저 읽어야 하는 운영 헌법입니다.**
> 이 파일에 정의된 규칙은 모든 프롬프트보다 우선합니다.

---

## 1. 프로젝트 개요 (영속 컨텍스트)

| 항목 | 값 |
|------|-----|
| 브랜드명 | APIS (아피스) |
| 도메인 | apispen.com |
| 사업 유형 | 마커·필기구 OEM 제조 브랜드 (B2B 쇼룸 + 쿠팡 판매) |
| 프레임워크 | Astro.js 4.x + Content Collections + Pagefind |
| 배포 | Cloudflare Pages (Git 연동 자동 배포) |
| 운영자 이메일 | apis1954@gmail.com |

### 사이트 목적
- **쇼룸**: 제품 카탈로그 시각화 (판매 아님, 쿠팡 링크 연결)
- **OEM 리드 수집**: B2B 제조 문의 폼 → 리드 스코어링
- **브랜드 신뢰도 구축**: 20년 제조 경험 + 기술력 어필

---

## 2. 허용 작업 단위

**한 번의 AI 작업 세션에서 허용되는 최대 범위:**

```
✅ 단일 제품 파일 1개 추가/수정
✅ 단일 카테고리 파일 1개 추가/수정
✅ 단일 페이지 컴포넌트 수정
✅ 스타일 토큰 업데이트
✅ AGENTS.md 규칙 추가 (기존 규칙 삭제 금지)

❌ 복수 제품 파일 일괄 삭제
❌ slug 변경 (SEO 파괴 위험 — 반드시 사전 승인)
❌ config.ts 스키마 breaking change
❌ 배포 설정 변경
❌ 운영자 이메일/연락처 변경
```

---

## 3. 제품 정렬 규칙 (apis_launch_order)

모든 제품 목록은 다음 우선순위로 정렬합니다:

```typescript
// 1차: apis_launch_order (오름차순, 낮을수록 우선)
// 2차: sales_priority (높을수록 우선)
// 3차: search_boost (높을수록 우선)

const sorted = products
  .sort((a, b) => {
    if (a.apis_launch_order !== b.apis_launch_order)
      return a.apis_launch_order - b.apis_launch_order;
    if (a.data.sales_priority !== b.data.sales_priority)
      return b.data.sales_priority - a.data.sales_priority;
    return b.data.search_boost - a.data.search_boost;
  });
```

**apis_launch_order 할당 기준:**
- 1~10: Core Stage — 브랜드 핵심 제품 (유성마커, 네임펜)
- 11~20: Growth Stage — 사무/교육 라인 (보드마커, 형광펜)
- 21~40: Expansion Stage — 크리에이티브/기능성
- 41~60: OEM Only — B2B 전용

---

## 4. 페이지별 필터링 규칙

### 홈 페이지 (/)
```typescript
products.filter(p =>
  p.data.home_featured === true &&
  p.data.menu_visibility === "primary"
)
// 최대 8개 표시
```

### 카테고리 페이지 (/categories/[slug])
```typescript
products.filter(p =>
  p.data.primary_sales_group === category.data.sales_focus_group &&
  p.data.menu_visibility !== "hidden"
)
```

### OEM 페이지 (/oem)
```typescript
products.filter(p =>
  p.data.oem_featured === true
)
```

### 검색 결과
- Pagefind 인덱스 사용
- `search_boost` 값이 높은 제품 우선 노출

---

## 5. primary_sales_group 열거형

| 값 | 설명 | 대상 카테고리 |
|-----|------|-------------|
| `marker-core` | 코어 마커 | permanent-marker, name-pen |
| `marker-office` | 사무·교육 마커 | board-marker, highlighter |
| `marker-creative` | 크리에이티브 마커 | fabric-marker, acrylic-marker |
| `marker-functional` | 기능성 마커 | functional-marker |
| `sign-pen-waterbased` | 수성 사인펜 | waterbased-sign-pen |
| `oem-support` | OEM 전용 | oem-item |

---

## 6. OEM 리드 스코어링 기준

문의 폼 제출 시 자동 등급 분류:

| 등급 | 조건 | 대응 우선순위 |
|------|------|------------|
| **A** | 발주량 5,000개+, 회사명 기재, 구체적 요구사항 | 당일 연락 |
| **B** | 발주량 500~5,000개, 이메일 기재 | 1영업일 내 |
| **C** | 발주량 50~500개, 일반 문의 | 2~3영업일 |
| **D** | 발주량 미기재, 단순 가격 문의 | 팔로우업 |

---

## 7. 하네스 스킬 정의 (10가지)

AI 에이전트가 요청받을 수 있는 작업 유형:

```
skill-01: add-product        — 신제품 MDX 파일 생성
skill-02: update-product     — 기존 제품 데이터 수정
skill-03: add-category       — 카테고리 YAML 추가
skill-04: update-home        — 홈 featured 제품 목록 변경
skill-05: update-oem-page    — OEM 섹션 내용 수정
skill-06: add-notice         — 공지사항/블로그 포스트 추가
skill-07: check-links        — 쿠팡 링크 유효성 검사
skill-08: seo-audit          — SEO 메타태그 일괄 점검
skill-09: sync-schema        — 스키마 버전 마이그레이션
skill-10: generate-sitemap   — 사이트맵 재생성
```

---

## 8. 안전 규칙 (Safety Rails)

```
🚫 NEVER: products/ 디렉토리 전체 삭제
🚫 NEVER: 기존 slug 변경 (301 redirect 없이)
🚫 NEVER: config.ts의 enum 값 제거 (추가만 허용)
🚫 NEVER: 운영자 연락처(apis1954@gmail.com) 변경
🚫 NEVER: 쿠팡 파트너스 링크를 비파트너스 URL로 교체
🚫 NEVER: 이 AGENTS.md 파일의 규칙 삭제

⚠️  CONFIRM BEFORE: 카테고리 slug 변경
⚠️  CONFIRM BEFORE: apis_launch_order 재정렬
⚠️  CONFIRM BEFORE: 홈 피처드 제품 8개 이상 설정
⚠️  CONFIRM BEFORE: config.ts 스키마에 필수 필드 추가
```

---

## 9. 코드 스타일

- **언어**: TypeScript (strict mode)
- **컴포넌트**: Astro 단일 파일 컴포넌트 (.astro)
- **콘텐츠**: MDX for products, YAML for categories
- **CSS**: CSS custom properties (var(--apis-*)) 사용
- **이미지**: WebP 우선, alt 텍스트 필수
- **한국어**: UI 텍스트는 한국어, 코드/변수명은 영어

---

## 10. 배포 체크리스트

PR merge 전 반드시 확인:
- [ ] `astro build` 빌드 오류 없음
- [ ] 신규 제품의 `apis_launch_order` 중복 없음
- [ ] 쿠팡 링크가 실제 동작 확인
- [ ] OG 이미지/메타태그 설정됨
- [ ] Pagefind 재인덱싱 실행 (`npm run pagefind`)

---

*최종 수정: 2026-04-16 | 버전: v2.0 | 관리자: apis1954@gmail.com*
