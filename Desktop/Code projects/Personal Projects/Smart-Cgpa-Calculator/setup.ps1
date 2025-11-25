# Smart CGPA Calculator - Installation & Setup Script
# Run this script in PowerShell to set up and verify the project

Write-Host "================================" -ForegroundColor Cyan
Write-Host "Smart CGPA Calculator Setup" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
Write-Host ""

# Check Node.js installation
Write-Host "Checking Node.js installation..." -ForegroundColor Yellow
$nodeVersion = node --version 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Node.js is not installed!" -ForegroundColor Red
    Write-Host "Please install Node.js 18+ from https://nodejs.org/" -ForegroundColor Yellow
    exit 1
}
Write-Host "✓ Node.js installed: $nodeVersion" -ForegroundColor Green
Write-Host ""

# Check npm installation
Write-Host "Checking npm installation..." -ForegroundColor Yellow
$npmVersion = npm --version 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ npm is not installed!" -ForegroundColor Red
    exit 1
}
Write-Host "✓ npm installed: v$npmVersion" -ForegroundColor Green
Write-Host ""

# Navigate to project directory
$projectPath = "c:\Users\rsneg\Desktop\Code projects\Personal Projects\Smart-Cgpa-Calculator"
Write-Host "Navigating to project directory..." -ForegroundColor Yellow
Set-Location $projectPath
Write-Host "✓ Working directory: $projectPath" -ForegroundColor Green
Write-Host ""

# Install dependencies
Write-Host "Installing dependencies (this may take a few minutes)..." -ForegroundColor Yellow
npm install
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Failed to install dependencies!" -ForegroundColor Red
    exit 1
}
Write-Host "✓ Dependencies installed successfully" -ForegroundColor Green
Write-Host ""

# Verify installation
Write-Host "Verifying installation..." -ForegroundColor Yellow
if (Test-Path "node_modules") {
    Write-Host "✓ node_modules folder exists" -ForegroundColor Green
} else {
    Write-Host "❌ node_modules folder not found!" -ForegroundColor Red
    exit 1
}
Write-Host ""

# Run tests
Write-Host "Running unit tests..." -ForegroundColor Yellow
npm test -- --passWithNoTests
if ($LASTEXITCODE -ne 0) {
    Write-Host "⚠ Some tests failed - please review" -ForegroundColor Yellow
} else {
    Write-Host "✓ All tests passed!" -ForegroundColor Green
}
Write-Host ""

# Build check
Write-Host "Verifying build configuration..." -ForegroundColor Yellow
npx tsc --noEmit
if ($LASTEXITCODE -ne 0) {
    Write-Host "⚠ TypeScript compilation has errors" -ForegroundColor Yellow
} else {
    Write-Host "✓ TypeScript configuration valid" -ForegroundColor Green
}
Write-Host ""

# Summary
Write-Host "================================" -ForegroundColor Cyan
Write-Host "Setup Complete!" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "  1. Start dev server:  npm run dev" -ForegroundColor White
Write-Host "  2. Run tests:         npm test" -ForegroundColor White
Write-Host "  3. Build for prod:    npm run build" -ForegroundColor White
Write-Host ""
Write-Host "Documentation:" -ForegroundColor Yellow
Write-Host "  - README.md           Main documentation" -ForegroundColor White
Write-Host "  - QUICKSTART.md       Quick start guide" -ForegroundColor White
Write-Host "  - docs/ROADMAP.md     Implementation roadmap" -ForegroundColor White
Write-Host "  - docs/UI-REFERENCE.md Design specifications" -ForegroundColor White
Write-Host ""
Write-Host "Ready to start? Run: npm run dev" -ForegroundColor Green
Write-Host ""
