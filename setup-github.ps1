# APIS 아피스 사이트 — GitHub 초기 설정 스크립트
# 실행 방법: 이 파일에서 마우스 우클릭 → "PowerShell로 실행"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  APIS 아피스 사이트 GitHub 설정 도우미" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# GitHub 사용자명 입력
$githubUser = Read-Host "GitHub 사용자명을 입력하세요 (예: sinzi1234)"
if ([string]::IsNullOrWhiteSpace($githubUser)) {
    Write-Host "❌ 사용자명을 입력해야 합니다." -ForegroundColor Red
    Read-Host "엔터를 눌러 종료"
    exit 1
}

# 저장소명 확인
$repoName = "apispen-site"
Write-Host ""
Write-Host "저장소명: $repoName" -ForegroundColor Yellow
Write-Host "GitHub URL: https://github.com/$githubUser/$repoName" -ForegroundColor Yellow
Write-Host ""

# Git 설치 확인
try {
    $gitVersion = git --version 2>&1
    Write-Host "✅ Git 확인: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Git이 설치되어 있지 않습니다." -ForegroundColor Red
    Write-Host "https://git-scm.com/download/win 에서 Git을 설치해 주세요." -ForegroundColor Yellow
    Read-Host "엔터를 눌러 종료"
    exit 1
}

# 현재 디렉토리 확인
$currentDir = Get-Location
Write-Host "현재 폴더: $currentDir" -ForegroundColor Gray
Write-Host ""

# GitHub에 저장소를 먼저 만들어달라는 안내
Write-Host "⚠️  먼저 GitHub에서 저장소를 만들어야 합니다!" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. https://github.com/new 접속" -ForegroundColor White
Write-Host "2. Repository name: apispen-site" -ForegroundColor White
Write-Host "3. Private 또는 Public 선택" -ForegroundColor White
Write-Host "4. README 추가 체크 해제 (중요!)" -ForegroundColor Red
Write-Host "5. 'Create repository' 클릭" -ForegroundColor White
Write-Host ""

$confirm = Read-Host "GitHub 저장소 생성을 완료하셨나요? (y/n)"
if ($confirm -ne 'y' -and $confirm -ne 'Y') {
    Write-Host "GitHub 저장소 생성 후 다시 실행해 주세요." -ForegroundColor Yellow
    Read-Host "엔터를 눌러 종료"
    exit 0
}

Write-Host ""
Write-Host "🔄 Git 초기화 중..." -ForegroundColor Cyan

# Git 초기화
git init
git add .
git commit -m "feat: APIS 아피스 사이트 초기 구성 - Harness Engineering v1.0"

Write-Host ""
Write-Host "🔄 GitHub에 연결 중..." -ForegroundColor Cyan

# 원격 저장소 연결
$remoteUrl = "https://github.com/$githubUser/$repoName.git"
git remote remove origin 2>$null  # 기존 remote가 있으면 제거
git remote add origin $remoteUrl
git branch -M main

Write-Host ""
Write-Host "🚀 GitHub에 업로드 중... (GitHub 로그인 팝업이 뜰 수 있습니다)" -ForegroundColor Cyan

git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "  ✅ GitHub 업로드 성공!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "저장소 URL: https://github.com/$githubUser/$repoName" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "📋 다음 단계 — Cloudflare Pages 연결:" -ForegroundColor Yellow
    Write-Host "1. https://dash.cloudflare.com 접속" -ForegroundColor White
    Write-Host "2. Workers & Pages → Pages → Create a project" -ForegroundColor White
    Write-Host "3. Connect to Git → $repoName 선택" -ForegroundColor White
    Write-Host "4. Build command: npm run build" -ForegroundColor White
    Write-Host "5. Output directory: dist" -ForegroundColor White
    Write-Host "6. Save and Deploy!" -ForegroundColor White
} else {
    Write-Host ""
    Write-Host "❌ 업로드 실패. 아래를 확인해 주세요:" -ForegroundColor Red
    Write-Host "- GitHub 사용자명이 정확한지 확인" -ForegroundColor Yellow
    Write-Host "- GitHub 저장소(apispen-site)가 생성되었는지 확인" -ForegroundColor Yellow
    Write-Host "- GitHub 로그인 팝업에서 인증 완료했는지 확인" -ForegroundColor Yellow
}

Write-Host ""
Read-Host "엔터를 눌러 종료"
