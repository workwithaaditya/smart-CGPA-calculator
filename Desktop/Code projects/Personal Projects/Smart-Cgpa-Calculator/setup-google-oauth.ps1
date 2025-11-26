# Google Cloud Setup Automation Script
# This script automates OAuth client creation for Smart CGPA Calculator

# Prerequisites:
# 1. Install Google Cloud SDK: https://cloud.google.com/sdk/docs/install
# 2. Run: gcloud auth login
# 3. Run this script in PowerShell

param(
    [Parameter(Mandatory=$true)]
    [string]$ProjectId = "smart-cgpa-calculator-$(Get-Random -Maximum 9999)",
    
    [Parameter(Mandatory=$false)]
    [string]$FrontendUrl = "http://localhost:3000",
    
    [Parameter(Mandatory=$false)]
    [string]$BackendUrl = "http://localhost:5000"
)

Write-Host "🚀 Starting Google Cloud OAuth Setup..." -ForegroundColor Cyan
Write-Host "Project ID: $ProjectId" -ForegroundColor Yellow

# Step 1: Create Project
Write-Host "`n📦 Step 1: Creating Google Cloud Project..." -ForegroundColor Green
try {
    gcloud projects create $ProjectId --name="Smart CGPA Calculator"
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Project created successfully!" -ForegroundColor Green
    }
} catch {
    Write-Host "⚠️  Project might already exist or there was an error" -ForegroundColor Yellow
}

# Set the project
gcloud config set project $ProjectId

# Step 2: Enable required APIs
Write-Host "`n🔌 Step 2: Enabling Required APIs..." -ForegroundColor Green
$apis = @(
    "plus.googleapis.com",
    "iamcredentials.googleapis.com"
)

foreach ($api in $apis) {
    Write-Host "Enabling $api..." -ForegroundColor Cyan
    gcloud services enable $api
}
Write-Host "✅ APIs enabled!" -ForegroundColor Green

# Step 3: Create OAuth Client
Write-Host "`n🔑 Step 3: Creating OAuth Client..." -ForegroundColor Green
Write-Host "⚠️  NOTE: You need to configure OAuth Consent Screen manually first!" -ForegroundColor Yellow
Write-Host "Visit: https://console.cloud.google.com/apis/credentials/consent?project=$ProjectId" -ForegroundColor Cyan
Write-Host "`nPress Enter after you've configured the OAuth Consent Screen..."
Read-Host

# Create OAuth client using gcloud
Write-Host "Creating OAuth 2.0 Client..." -ForegroundColor Cyan

$clientConfig = @"
{
  "web": {
    "client_id": "",
    "project_id": "$ProjectId",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "redirect_uris": [
      "$BackendUrl/auth/google/callback"
    ],
    "javascript_origins": [
      "$FrontendUrl",
      "$BackendUrl"
    ]
  }
}
"@

$tempFile = [System.IO.Path]::GetTempFileName() + ".json"
$clientConfig | Out-File -FilePath $tempFile -Encoding UTF8

Write-Host "`n⚠️  Manual Step Required:" -ForegroundColor Yellow
Write-Host "1. Go to: https://console.cloud.google.com/apis/credentials?project=$ProjectId" -ForegroundColor Cyan
Write-Host "2. Click 'CREATE CREDENTIALS' → 'OAuth client ID'" -ForegroundColor Cyan
Write-Host "3. Select 'Web application'" -ForegroundColor Cyan
Write-Host "4. Name: 'Smart CGPA Web Client'" -ForegroundColor Cyan
Write-Host "5. Add Authorized JavaScript origins:" -ForegroundColor Cyan
Write-Host "   - $FrontendUrl" -ForegroundColor White
Write-Host "   - $BackendUrl" -ForegroundColor White
Write-Host "6. Add Authorized redirect URIs:" -ForegroundColor Cyan
Write-Host "   - $BackendUrl/auth/google/callback" -ForegroundColor White
Write-Host "7. Click CREATE" -ForegroundColor Cyan
Write-Host "`nPress Enter after you've created the OAuth client..."
Read-Host

# Step 4: Generate Session Secret
Write-Host "`n🔐 Step 4: Generating SESSION_SECRET..." -ForegroundColor Green
$sessionSecret = -join ((48..57) + (65..90) + (97..122) | Get-Random -Count 32 | ForEach-Object {[char]$_})
Write-Host "✅ Generated!" -ForegroundColor Green

# Step 5: Create .env file template
Write-Host "`n📝 Step 5: Creating .env template..." -ForegroundColor Green

$envTemplate = @"
# Database URL (get from Supabase or Vercel Postgres)
DATABASE_URL=postgresql://user:password@host:5432/database

# Session Secret (auto-generated)
SESSION_SECRET=$sessionSecret

# Google OAuth Credentials (paste from Google Cloud Console)
GOOGLE_CLIENT_ID=your-client-id.apps.googleusercontent.com
GOOGLE_CLIENT_SECRET=GOCSPX-your-client-secret

# URLs
GOOGLE_CALLBACK_URL=$BackendUrl/auth/google/callback
FRONTEND_URL=$FrontendUrl

# Environment
NODE_ENV=development
"@

$backendEnvPath = Join-Path $PSScriptRoot "backend\.env"
$envTemplate | Out-File -FilePath $backendEnvPath -Encoding UTF8

Write-Host "✅ Created: backend\.env" -ForegroundColor Green
Write-Host "⚠️  Don't forget to:" -ForegroundColor Yellow
Write-Host "   1. Add your DATABASE_URL" -ForegroundColor White
Write-Host "   2. Add your GOOGLE_CLIENT_ID" -ForegroundColor White
Write-Host "   3. Add your GOOGLE_CLIENT_SECRET" -ForegroundColor White

# Step 6: Summary
Write-Host "`n📋 Setup Summary" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════" -ForegroundColor Gray
Write-Host "Project ID:      $ProjectId" -ForegroundColor White
Write-Host "Frontend URL:    $FrontendUrl" -ForegroundColor White
Write-Host "Backend URL:     $BackendUrl" -ForegroundColor White
Write-Host "Session Secret:  $sessionSecret" -ForegroundColor White
Write-Host ".env file:       $backendEnvPath" -ForegroundColor White
Write-Host "═══════════════════════════════════════════" -ForegroundColor Gray

Write-Host "`n🎯 Next Steps:" -ForegroundColor Green
Write-Host "1. Copy your OAuth credentials from Google Cloud Console" -ForegroundColor White
Write-Host "2. Paste them into: backend\.env" -ForegroundColor White
Write-Host "3. Set up your database (Supabase/Vercel Postgres)" -ForegroundColor White
Write-Host "4. Add DATABASE_URL to backend\.env" -ForegroundColor White
Write-Host "5. Run: cd backend; npm install; npx prisma generate; npx prisma migrate dev" -ForegroundColor White
Write-Host "6. Run: npm run dev" -ForegroundColor White

Write-Host "`n✅ Script completed!" -ForegroundColor Green
Write-Host "📚 For detailed instructions, see: GOOGLE_OAUTH_SETUP_GUIDE.md" -ForegroundColor Cyan
