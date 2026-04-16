# PRODUCT_SCHEMA v2.0 — APIS 제품 데이터 표준

> 모든 제품 MDX 파일은 이 스키마를 따라야 합니다.
> 파일 위치: `src/content/products/[slug].mdx`

---

## 필드 정의

```yaml
---
# ── 식별자 ────────────────────────────────────────────────────
id: "apis-capoff-72h-permanent-marker"
# 형식: "apis-[기능키워드]-[제품명]" (kebab-case, 소문자)
# ⚠️ 한번 설정 후 변경 금지 (SEO URL과 연동)

slug: "apis-capoff-72h-permanent-marker"
# id와 동일하게 설정

# ── 분류 ─────────────────────────────────────────────────────
category: "permanent-marker"
# 허용값: permanent-marker | name-pen | board-marker | highlighter |
#         fabric-marker | washable-marker | functional-marker |
#         waterbased-sign-pen | acrylic-marker | marker-set | oem-item

primary_sales_group: "marker-core"
# 허용값: marker-core | marker-office | marker-creative |
#         marker-functional | sign-pen-waterbased | oem-support

# ── 출시 단계 ──────────────────────────────────────────────────
apis_launch_stage: "core"
# 허용값: core | growth | expansion | oem-only

apis_launch_order: 1
# 숫자 (낮을수록 홈/카테고리 우선 표시)
# 1~10: core, 11~20: growth, 21~40: expansion, 41+: oem-only

# ── 노출 설정 ──────────────────────────────────────────────────
home_featured: true
# 홈 메인 섹션 표시 여부 (true인 제품 최대 8개만 표시)

oem_featured: true
# OEM 페이지 표시 여부

menu_visibility: "primary"
# 허용값: primary | secondary | hidden
# primary: 메인 네비, 카테고리 목록에 표시
# secondary: 카테고리 내부에만 표시
# hidden: 검색/직접 URL로만 접근 가능

# ── 제품 정보 ──────────────────────────────────────────────────
title: "APIS 72H 유성마커 (뚜껑OFF 지속형)"
title_short: "72H 유성마커"
# title_short: 카드/네비에서 사용하는 짧은 이름

subtitle: "국내 최초 72시간 캡오프 유성마커"
description: |
  72시간 뚜껑 없이도 마르지 않는 특수 잉크 기술. 
  물·에탄올·기름에 강한 최상급 내성. 
  종이·플라스틱·금속·유리 등 멀티서피스 적용 가능.

# ── 상세 스펙 ──────────────────────────────────────────────────
specs:
  ink_type: "유성"
  # 허용값: 유성 | 수성 | 아크릴 | UV | 형광
  
  tip_type: "chisel"
  # 허용값: bullet | chisel | fine | brush | dual
  
  tip_size_mm: 4.0
  # 팁 폭 (mm 단위 숫자)
  
  colors_available:
    - "블랙"
    - "블루"
    - "레드"
  
  quantity_per_pack: 12
  # 기본 판매 단위 수량
  
  moq_oem: 500
  # OEM 최소 발주량 (단위: 개)
  
  certifications:
    - "KC 안전인증"
  
  storage_temp: "-10~40°C"
  
  made_in: "Korea"

# ── 판매 채널 ──────────────────────────────────────────────────
coupang_url: "https://www.coupang.com/vp/products/XXXXXXX"
# 실제 쿠팡 파트너스 URL 입력
# 미정인 경우 "" (빈 문자열) — null/undefined 사용 금지

coupang_partners: true
# 파트너스 링크 여부 (수익 발생 여부)

# ── SEO ───────────────────────────────────────────────────────
seo_title: "APIS 72H 유성마커 — 72시간 캡오프 방수 마커"
seo_description: "72시간 뚜껑 없이도 마르지 않는 APIS 유성마커. 방수·내유 최상급. 쿠팡 직구매 가능."
seo_keywords:
  - "유성마커"
  - "방수마커"
  - "캡오프마커"
  - "네임펜"
  - "마커OEM"

og_image: "/images/products/apis-capoff-72h-og.jpg"
# OG 이미지 경로 (public/ 기준)

search_boost: 10
# Pagefind 검색 우선순위 (1~10, 높을수록 상단 노출)

# ── 내부 운영 ──────────────────────────────────────────────────
sales_priority: 10
# 내부 판매 우선순위 (1~10, apis_launch_order 동순위 시 사용)

is_active: true
# false이면 빌드 시 제외

created_at: "2026-04-16"
updated_at: "2026-04-16"
---

<!-- MDX 본문: 제품 상세 설명 (선택사항) -->

## 제품 특징

- **72시간 캡오프**: 뚜껑 없이도 72시간 건조 방지
- **멀티서피스**: 종이·플라스틱·금속·유리·골판지 모두 적용
- **방수·내유**: 물과 기름에 번지지 않는 고분자 잉크

## OEM 커스터마이징

- 잉크 색상 커스터마이징 가능 (Pantone 매칭)
- 외관 색상·로고 인쇄 가능
- 패키지 디자인 커스터마이징 가능
```

---

## 카테고리별 필수 tags

제품 MDX 파일 본문에서 `data-pagefind-filter` 속성으로 필터 연동:

| category | 권장 tags |
|----------|----------|
| permanent-marker | 유성, 방수, 내유, 내수 |
| name-pen | 멀티서피스, 극세, 이름쓰기 |
| board-marker | 보드용, 화이트보드, 수성 |
| highlighter | 형광, 수성, 번짐방지 |
| fabric-marker | 섬유, 세탁내성, 패브릭 |
| acrylic-marker | 아크릴, 불투명, 예술용 |
| functional-marker | 산업용, 철재, 내열 |

---

*최종 수정: 2026-04-16 | 버전: v2.0*
