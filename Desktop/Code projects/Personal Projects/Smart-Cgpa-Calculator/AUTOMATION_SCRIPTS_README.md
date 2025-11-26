# 🤖 Automated Google OAuth Setup Scripts

This folder contains automation scripts to simplify the Google Cloud OAuth setup process.

## 📋 Prerequisites

Before running these scripts, you need:

1. **Google Cloud SDK installed**
   - Windows: https://cloud.google.com/sdk/docs/install
   - Mac: `brew install --cask google-cloud-sdk`
   - Linux: https://cloud.google.com/sdk/docs/install#linux

2. **Authenticate with gcloud**
   ```bash
   gcloud auth login
   ```

3. **Enable billing** (if not already done)
   - Google Cloud requires billing enabled for API access
   - Visit: https://console.cloud.google.com/billing

## 🚀 Quick Start

### For Windows (PowerShell):

```powershell
# Navigate to project folder
cd "C:\Users\rsneg\Desktop\Code projects\Personal Projects\Smart-Cgpa-Calculator"

# Run the script
.\setup-google-oauth.ps1

# Or with custom URLs (for production)
.\setup-google-oauth.ps1 -ProjectId "my-cgpa-app" -FrontendUrl "https://my-app.vercel.app" -BackendUrl "https://my-backend.vercel.app"
```

### For Mac/Linux (Bash):

```bash
# Navigate to project folder
cd ~/Smart-Cgpa-Calculator

# Make script executable
chmod +x setup-google-oauth.sh

# Run the script
./setup-google-oauth.sh
```

## 🎯 What the Script Does

### Automated Steps:
1. ✅ Creates Google Cloud Project
2. ✅ Enables required APIs (Google+ API, IAM)
3. ✅ Generates random SESSION_SECRET
4. ✅ Creates `backend/.env` file with template
5. ✅ Provides direct links to complete setup

### Manual Steps (Script Guides You):
1. ⚠️ Configure OAuth Consent Screen (opens link)
2. ⚠️ Create OAuth Client ID (opens link)
3. ⚠️ Copy credentials to `.env` file
4. ⚠️ Set up database connection

## 📝 After Running the Script

1. **Open the generated `.env` file**:
   ```
   backend/.env
   ```

2. **Add your OAuth credentials**:
   - Copy `GOOGLE_CLIENT_ID` from Google Cloud Console
   - Copy `GOOGLE_CLIENT_SECRET` from Google Cloud Console

3. **Add your database URL**:
   - Get from Supabase: https://supabase.com/dashboard
   - Or from Vercel Postgres: https://vercel.com/storage

4. **Run database migrations**:
   ```bash
   cd backend
   npm install
   npx prisma generate
   npx prisma migrate dev --name init
   ```

5. **Start your servers**:
   ```bash
   # Terminal 1: Backend
   cd backend
   npm run dev

   # Terminal 2: Frontend
   npm run dev
   ```

## 🔧 Script Parameters

### PowerShell Script:

```powershell
-ProjectId          # Custom project ID (default: auto-generated)
-FrontendUrl        # Frontend URL (default: http://localhost:3000)
-BackendUrl         # Backend URL (default: http://localhost:5000)
```

**Example**:
```powershell
.\setup-google-oauth.ps1 `
  -ProjectId "smart-cgpa-prod" `
  -FrontendUrl "https://cgpa.vercel.app" `
  -BackendUrl "https://api-cgpa.vercel.app"
```

## ⚠️ Important Notes

1. **OAuth Consent Screen**: Cannot be automated due to Google's security policies. You must configure it manually through the provided link.

2. **OAuth Client Creation**: Also requires manual creation, but the script provides exact values to use.

3. **Database Setup**: Choose between:
   - Supabase (free, easy)
   - Vercel Postgres (integrated with Vercel)
   - Any PostgreSQL database

4. **Credentials Security**: 
   - Never commit `.env` files to git
   - Keep credentials private
   - Use different credentials for production

## 🐛 Troubleshooting

### Script fails with "gcloud: command not found"
- Install Google Cloud SDK (see prerequisites)
- Restart your terminal after installation

### "Project already exists" error
- Project ID must be globally unique
- Use a different ProjectId parameter

### "Insufficient permissions" error
- Make sure you're logged in: `gcloud auth login`
- Check you have billing enabled
- Verify you have project creation permissions

### Can't find .env file after script runs
- Check `backend/.env` (created in backend folder)
- Make sure you ran the script from project root

## 📚 Manual Setup Alternative

If you prefer manual setup or the script doesn't work:
- Follow the step-by-step guide: `GOOGLE_OAUTH_SETUP_GUIDE.md`

## 🎉 Success Indicators

After successful setup, you should have:
- ✅ Google Cloud project created
- ✅ APIs enabled
- ✅ `backend/.env` file with credentials
- ✅ OAuth client configured
- ✅ Database connected
- ✅ Sign-in button working in your app

## 📞 Need Help?

If you encounter issues:
1. Check the troubleshooting section above
2. Review the detailed guide: `GOOGLE_OAUTH_SETUP_GUIDE.md`
3. Check Google Cloud Console for error messages
4. Verify all environment variables are set correctly

---

**Created by Aaditya** | Smart CGPA Calculator
