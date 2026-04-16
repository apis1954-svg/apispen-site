# APIS 아피스 — 공식 쇼룸 사이트

> **apispen.com** | 마커·필기구 전문 OEM 제조 브랜드

Astro.js 기반 정적 사이트 | Cloudflare Pages 배포 | Pagefind 검색

---

## 🚀 5분 배포 가이드

### 사전 준비
- GitHub 계정
- Cloudflare 계정 (무료)
- Node.js 18 이상 설치

---

### 1단계 — GitHub 저장소 만들기

[github.com/new](https://github.com/new) 접속 후:
- Repository name: `apispen-site`
- Private 또는 Public 선택 (둘 다 무료 배포 가능)
- **"Create repository"** 클릭

---

### 2단계 — 코드 업로드

**Windows PowerShell** 또는 **Git Bash**에서 실행:

```powershell
# 이 폴더로 이동 (압축 해제한 경로로 변경)
cd "C:\Users\sinzi\Documents\Claude\Claude_Work\apispen-site"

# Git 초기화
git init
git add .
git commit -m "feat: APIS 아피스 사이트 초기 구성"

# GitHub 저장소 연결 (YOUR_USERNAME을 실제 GitHub ID로 변경)
git remote add origin https://github.com/YOUR_USERNAME/apispen-site.git
git branch -M main
git push -u origin main
```

---

### 3단계 — Cloudflare Pages 연결

1. [dash.cloudflare.com](https://dash.cloudflare.com) 로그인
2. 왼쪽 메뉴 **"Workers & Pages"** → **"Pages"**
3. **"Create a project"** → **"Connect to Git"**
4. GitHub 계정 연결 → `apispen-site` 저장소 선택
5. 빌드 설정 입력:

   | 항목 | 값 |
   |------|-----|
   | Framework preset | **Astro** |
   | Build command | `npm run build` |
   | Build output | `dist` |

6. **"Save and Deploy"** → 약 1분 후 배포 완료
7. `*.pages.dev` URL로 사이트 확인

---

### 4단계 — 커스텀 도메인 연결 (apispen.com)

1. Cloudflare Pages 프로젝트 → **"Custom domains"** 탭
2. **"Set up a custom domain"** → `apispen.com` 입력
3. **Cloudflare DNS 사용 중이면** 자동 설정 완료
4. 타 DNS 사용 중이면 CNAME 레코드 추가 안내 따르기

---

### 5단계 — GitHub Secrets 설정 (자동 배포)

GitHub Actions가 Cloudflare에 자동 배포하려면 두 가지 시크릿 필요:

**GitHub 저장소** → Settings → Secrets and variables → Actions

| Secret 이름 | 값 |
|------------|-----|
| `CLOUDFLARE_API_TOKEN` | Cloudflare API 토큰 (아래 참조) |
| `CLOUDFLARE_ACCOUNT_ID` | Cloudflare 계정 ID |

**Cloudflare API 토큰 발급:**
1. [dash.cloudflare.com/profile/api-tokens](https://dash.cloudflare.com/profile/api-tokens)
2. **"Create Token"** → **"Custom token"**
3. 권한: `Cloudflare Pages — Edit`
4. 생성 후 토큰 복사 → GitHub Secrets에 입력

**Cloudflare 계정 ID:**
- Cloudflare 대시보드 오른쪽 사이드바에서 확인

---

## 📁 프로젝트 구조

```
apispen-site/
├── .github/workflows/deploy.yml    ← GitHub Actions 자동 배포
├── docs/
│   ├── AGENTS.md                   ← AI 운영 규칙 (필독!)
│   ├── PRODUCT_SCHEMA_v2.md        ← 제품 데이터 표준
│   ├── CATEGORY_SCHEMA_v2.md       ← 카테고리 표준
│   └── DEPLOY_GUIDE.md             ← 상세 배포 가이드
├── public/
│   ├── _headers                    ← Cloudflare 보안 헤더
│   └── _redirects                  ← URL 리다이렉트 규칙
├── src/
│   ├── content/
│   │   ├── config.ts               ← Content Collections 스키마
│   │   ├── categories/             ← 카테고리 YAML (7개)
│   │   └── products/               ← 제품 MDX (11개, 27개 예정)
│   ├── layouts/BaseLayout.astro    ← 공통 레이아웃
│   └── pages/
│       ├── index.astro             ← 홈
│       ├── categories/             ← 카테고리 목록 + 상세
│       ├── products/[slug].astro   ← 제품 상세
│       ├── oem.astro               ← OEM 상담
│       └── notices/                ← 공지사항
├── astro.config.mjs
├── package.json
└── tsconfig.json
```

---

## 🛠 로컬 개발

```bash
# 의존성 설치
npm install

# 개발 서버 시작 (http://localhost:4321)
npm run dev

# 프로덕션 빌드
npm run build

# 빌드 미리보기
npm run preview

# Pagefind 검색 인덱스 생성 (빌드 후)
npx pagefind --site dist
```

---

## ✍️ 제품 추가하기

`src/content/products/` 폴더에 MDX 파일 추가:

```bash
# 파일명 형식: apis-[기능]-[제품명].mdx
# 예: apis-new-product.mdx
```

`docs/PRODUCT_SCHEMA_v2.md` 스키마 참고 후 frontmatter 작성.

**AI 에이전트로 추가 시** `docs/AGENTS.md` 먼저 읽기.

---

## 📊 현재 제품 현황

| 단계 | 제품 수 | 상태 |
|------|--------|------|
| Phase 1 (Core) | 3 | ✅ 완료 |
| Phase 2 (Growth) | 4 | ✅ 완료 |
| Phase 3 (Expansion) | 4 | ✅ 완료 |
| 나머지 | 16 | 🔄 준비 중 |
| **합계** | **27** | |

---

## 📧 문의

- **운영자**: apis1954@gmail.com
- **사이트**: apispen.com
