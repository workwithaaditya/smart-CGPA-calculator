#!/bin/bash
# Google Cloud Setup Automation Script (Bash version)
# For Linux/Mac users

set -e

PROJECT_ID="smart-cgpa-calculator-$RANDOM"
FRONTEND_URL="http://localhost:3000"
BACKEND_URL="http://localhost:5000"

echo "🚀 Starting Google Cloud OAuth Setup..."
echo "Project ID: $PROJECT_ID"

# Step 1: Create Project
echo ""
echo "📦 Step 1: Creating Google Cloud Project..."
gcloud projects create "$PROJECT_ID" --name="Smart CGPA Calculator" || echo "⚠️  Project might already exist"

# Set the project
gcloud config set project "$PROJECT_ID"

# Step 2: Enable required APIs
echo ""
echo "🔌 Step 2: Enabling Required APIs..."
gcloud services enable plus.googleapis.com
gcloud services enable iamcredentials.googleapis.com
echo "✅ APIs enabled!"

# Step 3: OAuth Consent Screen (Manual)
echo ""
echo "🔑 Step 3: Configuring OAuth..."
echo "⚠️  NOTE: You need to configure OAuth Consent Screen manually first!"
echo "Visit: https://console.cloud.google.com/apis/credentials/consent?project=$PROJECT_ID"
echo ""
echo "Press Enter after you've configured the OAuth Consent Screen..."
read

echo ""
echo "⚠️  Manual Step Required:"
echo "1. Go to: https://console.cloud.google.com/apis/credentials?project=$PROJECT_ID"
echo "2. Click 'CREATE CREDENTIALS' → 'OAuth client ID'"
echo "3. Select 'Web application'"
echo "4. Name: 'Smart CGPA Web Client'"
echo "5. Add Authorized JavaScript origins:"
echo "   - $FRONTEND_URL"
echo "   - $BACKEND_URL"
echo "6. Add Authorized redirect URIs:"
echo "   - $BACKEND_URL/auth/google/callback"
echo "7. Click CREATE"
echo ""
echo "Press Enter after you've created the OAuth client..."
read

# Step 4: Generate Session Secret
echo ""
echo "🔐 Step 4: Generating SESSION_SECRET..."
SESSION_SECRET=$(openssl rand -base64 32)
echo "✅ Generated!"

# Step 5: Create .env file
echo ""
echo "📝 Step 5: Creating .env template..."

cat > backend/.env << EOF
# Database URL (get from Supabase or Vercel Postgres)
DATABASE_URL=postgresql://user:password@host:5432/database

# Session Secret (auto-generated)
SESSION_SECRET=$SESSION_SECRET

# Google OAuth Credentials (paste from Google Cloud Console)
GOOGLE_CLIENT_ID=your-client-id.apps.googleusercontent.com
GOOGLE_CLIENT_SECRET=GOCSPX-your-client-secret

# URLs
GOOGLE_CALLBACK_URL=$BACKEND_URL/auth/google/callback
FRONTEND_URL=$FRONTEND_URL

# Environment
NODE_ENV=development
EOF

echo "✅ Created: backend/.env"
echo "⚠️  Don't forget to:"
echo "   1. Add your DATABASE_URL"
echo "   2. Add your GOOGLE_CLIENT_ID"
echo "   3. Add your GOOGLE_CLIENT_SECRET"

# Summary
echo ""
echo "📋 Setup Summary"
echo "═══════════════════════════════════════════"
echo "Project ID:      $PROJECT_ID"
echo "Frontend URL:    $FRONTEND_URL"
echo "Backend URL:     $BACKEND_URL"
echo "Session Secret:  $SESSION_SECRET"
echo ".env file:       backend/.env"
echo "═══════════════════════════════════════════"

echo ""
echo "🎯 Next Steps:"
echo "1. Copy your OAuth credentials from Google Cloud Console"
echo "2. Paste them into: backend/.env"
echo "3. Set up your database (Supabase/Vercel Postgres)"
echo "4. Add DATABASE_URL to backend/.env"
echo "5. Run: cd backend && npm install && npx prisma generate && npx prisma migrate dev"
echo "6. Run: npm run dev"

echo ""
echo "✅ Script completed!"
echo "📚 For detailed instructions, see: GOOGLE_OAUTH_SETUP_GUIDE.md"
