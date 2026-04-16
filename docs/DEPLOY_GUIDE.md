# apispen.com 배포 가이드

## 배포 환경
- **플랫폼**: Cloudflare Pages
- **도메인**: apispen.com
- **소스**: GitHub 저장소 연동 (자동 배포)

---

## 1단계: GitHub 저장소 생성

```bash
# 1. GitHub에 새 저장소 생성 (예: apispen-site)
# 2. 이 폴더를 업로드

git init
git add .
git commit -m "feat: APIS 아피스 사이트 초기 구성"
git remote add origin https://github.com/[YOUR_USERNAME]/apispen-site.git
git push -u origin main
```

---

## 2단계: Cloudflare Pages 연결

1. [dash.cloudflare.com](https://dash.cloudflare.com) → Pages
2. **"Create a project"** → **"Connect to Git"**
3. GitHub 저장소 선택: `apispen-site`
4. 빌드 설정:
   - **Framework preset**: Astro
   - **Build command**: `npm run build`
   - **Build output directory**: `dist`
5. **"Save and Deploy"** 클릭

---

## 3단계: 커스텀 도메인 연결

1. Cloudflare Pages 프로젝트 → **Custom domains**
2. **"Set up a custom domain"** → `apispen.com` 입력
3. DNS 설정 확인 (Cloudflare DNS 사용 시 자동)

---

## 4단계: Pagefind 검색 인덱스

```bash
# 빌드 후 실행
npm run build
npx pagefind --site dist

# dist/ 폴더에 /pagefind/ 디렉토리 생성됨
# Cloudflare Pages는 자동으로 이 파일도 서빙
```

---

## 콘텐츠 업데이트 워크플로우

1. 제품 MDX 파일 추가/수정: `src/content/products/[slug].mdx`
2. AGENTS.md 규칙 확인 (AI 작업 시)
3. `git commit && git push`
4. Cloudflare Pages 자동 빌드·배포 (1~2분)

---

## Gmail 앱 비밀번호 설정 (모니터링용)

1. [myaccount.google.com/security](https://myaccount.google.com/security)
2. **2단계 인증** 활성화 확인
3. **앱 비밀번호** → "기타(직접 입력)" → "APIS 모니터링"
4. 생성된 16자리 비밀번호 복사
5. `harness_monitoring/config.json`의 `app_password`에 입력

---

*작성일: 2026-04-16*
