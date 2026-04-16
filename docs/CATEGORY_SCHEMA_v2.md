# CATEGORY_SCHEMA v2.0 — APIS 카테고리 데이터 표준

> 모든 카테고리 YAML 파일은 이 스키마를 따라야 합니다.
> 파일 위치: `src/content/categories/[slug].yaml`

---

## 필드 정의

```yaml
# ── 식별자 ────────────────────────────────────────────────────
id: "core-markers"
# 형식: "[그룹명]-[유형]" (kebab-case)

slug: "core-markers"
# id와 동일

# ── 기본 정보 ──────────────────────────────────────────────────
title: "코어 마커"
title_en: "Core Markers"
subtitle: "유성마커·네임펜 핵심 라인"
description: |
  아피스의 핵심 제품군. 72H 내수 잉크와 멀티서피스 기술을 탑재한
  유성마커와 네임펜 전문 라인업입니다.

# ── 분류 연결 ──────────────────────────────────────────────────
sales_focus_group: "marker-core"
# 이 카테고리에 속하는 primary_sales_group 값

included_categories:
  - "permanent-marker"
  - "name-pen"
# 이 카테고리에 포함되는 product.category 값 목록

# ── UI 설정 ──────────────────────────────────────────────────
icon: "🖊️"
# 이모지 또는 아이콘 식별자

display_order: 1
# 카테고리 목록 정렬 순서

hero_color: "#e94560"
# 카테고리 페이지 강조 색상 (hex)

is_active: true

# ── SEO ───────────────────────────────────────────────────────
seo_title: "코어 마커 — 유성마커·네임펜 | APIS 아피스"
seo_description: "APIS 유성마커와 네임펜. 72시간 캡오프 기술과 멀티서피스 잉크로 모든 표면에 선명하게."
og_image: "/images/categories/core-markers-og.jpg"
```

---

## 카테고리 목록 (7개 고정)

| id | sales_focus_group | display_order | icon |
|----|------------------|---------------|------|
| `core-markers` | `marker-core` | 1 | 🖊️ |
| `office-education-markers` | `marker-office` | 2 | 📊 |
| `creative-markers` | `marker-creative` | 3 | 🎨 |
| `functional-markers` | `marker-functional` | 4 | 🔧 |
| `waterbased-sign-pens` | `sign-pen-waterbased` | 5 | ✒️ |
| `marker-sets` | `marker-core` | 6 | 📦 |
| `oem-available-items` | `oem-support` | 7 | 🏭 |

---

*최종 수정: 2026-04-16 | 버전: v2.0*
