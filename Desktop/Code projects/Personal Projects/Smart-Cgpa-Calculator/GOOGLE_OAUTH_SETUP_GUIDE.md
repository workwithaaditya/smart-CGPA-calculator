# 🔐 Google OAuth Setup Guide - Smart CGPA Calculator

## Step 1: Go to Google Cloud Console

1. Open your browser and go to: **https://console.cloud.google.com/**
2. Sign in with your Google account

---

## Step 2: Create a New Project

1. Click on the **project dropdown** at the top (next to "Google Cloud")
2. Click **"NEW PROJECT"** button (top right)
3. Fill in:
   - **Project name**: `Smart CGPA Calculator`
   - **Organization**: Leave as "No organization"
4. Click **"CREATE"**
5. Wait 10-20 seconds for project creation
6. Click **"SELECT PROJECT"** when it appears

---

## Step 3: Enable Google+ API

1. In the left sidebar, click **"APIs & Services"** → **"Library"**
2. In the search bar, type: `Google+ API`
3. Click on **"Google+ API"**
4. Click the blue **"ENABLE"** button
5. Wait for it to enable (~5 seconds)

---

## Step 4: Configure OAuth Consent Screen

1. Go to **"APIs & Services"** → **"OAuth consent screen"** (left sidebar)
2. Select **"External"** user type
3. Click **"CREATE"**

### Fill in App Information:

**Page 1 - OAuth consent screen:**
- **App name**: `Smart CGPA Calculator`
- **User support email**: Select your email from dropdown
- **App logo**: Skip (optional)
- **Application home page**: `http://localhost:3000` (for now)
- **Authorized domains**: Leave empty for now
- **Developer contact information**: Enter your email
- Click **"SAVE AND CONTINUE"**

**Page 2 - Scopes:**
- Click **"SAVE AND CONTINUE"** (no need to add scopes)

**Page 3 - Test users:**
- Click **"+ ADD USERS"**
- Enter your email address
- Click **"ADD"**
- Click **"SAVE AND CONTINUE"**

**Page 4 - Summary:**
- Review and click **"BACK TO DASHBOARD"**

---

## Step 5: Create OAuth Client ID

1. Go to **"APIs & Services"** → **"Credentials"** (left sidebar)
2. Click **"+ CREATE CREDENTIALS"** at the top
3. Select **"OAuth client ID"**

### Configure the OAuth Client:

1. **Application type**: Select **"Web application"**
2. **Name**: `Smart CGPA Web Client`

### Add Authorized JavaScript Origins:

Click **"+ ADD URI"** under "Authorized JavaScript origins":
```
http://localhost:3000
http://localhost:5000
```

### Add Authorized Redirect URIs:

Click **"+ ADD URI"** under "Authorized redirect URIs":
```
http://localhost:5000/auth/google/callback
```

*Note: We'll add production URLs later after deployment*

3. Click **"CREATE"**

---

## Step 6: Copy Your Credentials

A popup will appear with:
- **Your Client ID**: `123456789-xxxxxxxxx.apps.googleusercontent.com`
- **Your Client Secret**: `GOCSPX-xxxxxxxxxxxxxx`

**IMPORTANT**: 
- Click the **copy icons** to copy both
- Save them somewhere safe (Notepad++)
- Don't share these publicly!

---

## Step 7: Update Your Backend .env File

1. Open: `backend/.env` file
2. Add these lines (replace with your actual values):

```env
# Database (you may already have this)
DATABASE_URL=postgresql://your-database-url

# Session Secret (generate a random string)
SESSION_SECRET=your-random-secret-key-here

# Google OAuth Credentials (paste what you copied)
GOOGLE_CLIENT_ID=paste-your-client-id-here.apps.googleusercontent.com
GOOGLE_CLIENT_SECRET=paste-your-client-secret-here

# Callback URL
GOOGLE_CALLBACK_URL=http://localhost:5000/auth/google/callback

# Frontend URL
FRONTEND_URL=http://localhost:3000

# Environment
NODE_ENV=development
```

---

## Step 8: Generate SESSION_SECRET

You need a random secret key. Run this command in PowerShell:

```powershell
-join ((48..57) + (65..90) + (97..122) | Get-Random -Count 32 | ForEach-Object {[char]$_})
```

Copy the output and paste it as your `SESSION_SECRET`

---

## Step 9: Set Up Database (Choose One)

### Option A: Use Supabase (Free & Easy)

1. Go to **https://supabase.com/dashboard**
2. Click **"New project"**
3. Fill in:
   - **Name**: `smart-cgpa-db`
   - **Database Password**: Create a strong password (save it!)
   - **Region**: Choose closest to you
4. Click **"Create new project"** (takes 2-3 minutes)
5. Once ready, go to **"Settings"** → **"Database"**
6. Copy the **"Connection string"** under "URI"
7. Replace `[YOUR-PASSWORD]` in the connection string with your password
8. Paste as `DATABASE_URL` in `.env`

### Option B: Use Vercel Postgres

1. Go to your Vercel dashboard
2. Click **"Storage"** → **"Create Database"**
3. Select **"Postgres"**
4. Copy the connection string
5. Paste as `DATABASE_URL` in `.env`

---

## Step 10: Run Database Migration

Open PowerShell in your project folder:

```powershell
cd backend
npm install
npx prisma generate
npx prisma migrate dev --name init
```

---

## Step 11: Start Your Backend Server

```powershell
cd backend
npm run dev
```

You should see:
```
Server running on http://localhost:5000
```

---

## Step 12: Test the Complete Flow

1. **Frontend already running**: http://localhost:3000
2. **Backend now running**: http://localhost:5000
3. Open http://localhost:3000 in your browser
4. Click **"Sign In"** button (top-right)
5. You should be redirected to Google login
6. Choose your Google account
7. Grant permissions
8. You'll be redirected back to the app
9. Your name and avatar should appear in top-right corner!

---

## 🎉 Success!

If you see your name and profile picture after signing in, it's working!

Now your data will sync to the cloud whenever you're logged in.

---

## 🐛 Troubleshooting

### Error: "redirect_uri_mismatch"
- Make sure you added `http://localhost:5000/auth/google/callback` to Authorized redirect URIs
- Check for typos or extra spaces

### Error: "Invalid client"
- Verify `GOOGLE_CLIENT_ID` and `GOOGLE_CLIENT_SECRET` are correct in `.env`
- Make sure no extra quotes or spaces

### Can't connect to database
- Check `DATABASE_URL` is correct
- Ensure database server is running
- Verify password in connection string is correct

### Backend won't start
- Make sure you ran `npm install` in backend folder
- Check that `.env` file is in the `backend` folder
- Verify all environment variables are set

---

## 📝 For Production Deployment

When you deploy to Vercel/production:

1. Go back to Google Cloud Console → Credentials
2. Edit your OAuth client
3. Add production URLs:
   - **JavaScript origins**: `https://your-app.vercel.app`
   - **Redirect URIs**: `https://your-backend.vercel.app/auth/google/callback`
4. Update environment variables in Vercel dashboard
5. Redeploy

---

**Need help?** Check the console logs for detailed error messages!

**Built by Aaditya** 🚀
