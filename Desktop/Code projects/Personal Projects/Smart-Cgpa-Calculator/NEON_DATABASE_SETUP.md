# 🗄️ Neon PostgreSQL Database Setup Guide

Complete guide to set up your **Neon PostgreSQL database** for Smart CGPA Calculator - following the exact same pattern as your Smart Attendance Management project.

---

## 📋 What is Neon?

**Neon** is a **serverless PostgreSQL** database with:
- ✅ **Free Tier**: 3GB storage, unlimited queries
- ✅ **Auto-scaling**: Scales up/down automatically
- ✅ **Instant Setup**: No server management required
- ✅ **Global CDN**: Low latency worldwide
- ✅ **Auto-suspend**: Saves resources when idle

**Perfect for production deployment on Vercel!**

---

## 🚀 Step 1: Create Neon Account

### 1.1 Sign Up
1. Go to [https://neon.tech](https://neon.tech)
2. Click **"Sign Up"**
3. Choose **"Continue with GitHub"** (recommended)
4. Authorize Neon to access your GitHub account

### 1.2 Create New Project
1. After sign-in, click **"Create a Project"** or **"New Project"**
2. Fill in project details:
   - **Project Name**: `smart-cgpa-database`
   - **Database Name**: `cgpa_db` (or leave default `neondb`)
   - **Region**: Choose closest to you
     - US East (N. Virginia) - for US users
     - Europe (Frankfurt) - for EU users
     - Asia Pacific (Singapore) - for Asia users
3. Click **"Create Project"**

---

## 🔑 Step 2: Get Database Connection String

### 2.1 Copy Connection Details
After project creation, you'll see a **Connection Details** panel.

1. Under **"Connection String"**, select **"Pooled connection"**
2. Click **"Copy"** to copy the full connection string
3. It should look like:
   ```
   postgresql://username:password@ep-cool-forest-123456.region.aws.neon.tech/neondb?sslmode=require
   ```

### 2.2 Important Notes
- ✅ Keep the `?sslmode=require` at the end
- ✅ Use **pooled connection** for production (better performance)
- ✅ Save this string securely - you'll need it for `.env` file

---

## 🛠️ Step 3: Set Up Local Development

### 3.1 Create `.env` File (Backend)
1. Navigate to your project's backend folder:
   ```powershell
   cd backend
   ```

2. Create `.env` file (copy from `.env.example`):
   ```powershell
   Copy-Item .env.example .env
   ```

3. Open `.env` and update these values:

```env
# Database (Neon PostgreSQL)
DATABASE_URL="postgresql://your-username:your-password@ep-xxx-xxx.region.aws.neon.tech/neondb?sslmode=require"

# NextAuth.js Configuration
NEXTAUTH_SECRET="run-this-command: -join ((48..57) + (65..90) + (97..122) | Get-Random -Count 32 | ForEach-Object {[char]$_})"
NEXTAUTH_URL="http://localhost:3000"

# Google OAuth (we'll set this up next in GOOGLE_OAUTH_SETUP_GUIDE.md)
GOOGLE_CLIENT_ID="your-client-id.apps.googleusercontent.com"
GOOGLE_CLIENT_SECRET="your-client-secret"

# Frontend URL
FRONTEND_URL="http://localhost:3000"

# Server Configuration
PORT=5000
NODE_ENV="development"
```

### 3.2 Generate NEXTAUTH_SECRET
Run this command in PowerShell to generate a secure secret:

```powershell
-join ((48..57) + (65..90) + (97..122) | Get-Random -Count 32 | ForEach-Object {[char]$_})
```

Copy the output and paste it as `NEXTAUTH_SECRET` in your `.env` file.

---

## 📦 Step 4: Install Dependencies

Make sure you're in the `backend` folder:

```powershell
cd backend
npm install
```

This will install Prisma and other required dependencies.

---

## 🔄 Step 5: Run Database Migration

### 5.1 Generate Prisma Client
```powershell
npx prisma generate
```

This creates the TypeScript types for your database models.

### 5.2 Create Database Tables
```powershell
npx prisma migrate dev --name init
```

**What this does:**
- Creates migration files in `prisma/migrations/`
- Connects to your Neon database
- Creates all tables (User, Account, Session, Subject, Semester)
- Generates Prisma client

**Expected output:**
```
✔ Generated Prisma Client
✔ The migration has been created successfully
✔ Applied 1 migration
```

---

## 🎨 Step 6: View Your Database (Optional)

### Open Prisma Studio
```powershell
npx prisma studio
```

This opens a visual database browser at `http://localhost:5555`

You can:
- ✅ View all tables
- ✅ Add/edit/delete records
- ✅ Test relationships
- ✅ Debug data issues

---

## ✅ Step 7: Verify Setup

### 7.1 Check Connection
Test if your backend can connect to Neon:

```powershell
npm run dev
```

If you see:
```
🚀 Server running on http://localhost:5000
✅ Database connected successfully
```

**Success!** Your Neon database is set up correctly.

### 7.2 Common Issues

**Error: "Can't reach database server"**
- ✅ Check DATABASE_URL is correct in `.env`
- ✅ Ensure connection string ends with `?sslmode=require`
- ✅ Verify Neon project is active (check Neon dashboard)

**Error: "P1001: Can't reach database"**
- ✅ Check internet connection
- ✅ Verify firewall isn't blocking port 5432
- ✅ Try regenerating connection string from Neon dashboard

**Error: "Invalid DATABASE_URL"**
- ✅ No spaces in connection string
- ✅ Password special characters might need URL encoding
- ✅ Use pooled connection string (not direct)

---

## 🌐 Step 8: Production Setup (Vercel)

### 8.1 Add Environment Variable to Vercel

1. Go to your Vercel project dashboard
2. Navigate to **Settings** → **Environment Variables**
3. Add:
   - **Name**: `DATABASE_URL`
   - **Value**: Your Neon connection string (pooled)
   - **Environments**: Select **all** (Production, Preview, Development)
4. Click **"Save"**

### 8.2 Update Google OAuth URLs

Once you deploy to production (e.g., `https://smart-cgpa-calculator-kohl.vercel.app`):

1. Go to [Google Cloud Console](https://console.cloud.google.com/apis/credentials)
2. Edit your OAuth 2.0 Client ID
3. Add production URLs:
   - **Authorized JavaScript origins**: `https://smart-cgpa-calculator-kohl.vercel.app`
   - **Authorized redirect URIs**: `https://smart-cgpa-calculator-kohl.vercel.app/api/auth/callback/google`
4. Update `.env` in Vercel:
   - `NEXTAUTH_URL="https://smart-cgpa-calculator-kohl.vercel.app"`
   - `FRONTEND_URL="https://smart-cgpa-calculator-kohl.vercel.app"`

### 8.3 Run Migrations on Production

After deploying backend to Vercel:

```powershell
# Pull Vercel environment variables locally
cd backend
vercel env pull

# Run migrations on production database
npx prisma migrate deploy
```

---

## 📊 Database Schema Overview

Your Neon database will have these tables:

### **User** (NextAuth.js)
- Stores authenticated user information
- Links to Google account

### **Account** (NextAuth.js)
- OAuth provider details
- Access/refresh tokens

### **Session** (NextAuth.js)
- Active user sessions
- Session tokens

### **VerificationToken** (NextAuth.js)
- Email verification tokens

### **Subject**
- User's CGPA subjects
- CIE, SEE, credits, grade points
- Links to User via userId

### **Semester**
- Multi-semester support
- Groups subjects by semester
- Links to User via userId

---

## 🎯 Usage Limits (Free Tier)

### Neon Free Tier Includes:
- ✅ **3GB storage** (enough for ~100,000 subject records)
- ✅ **Unlimited queries**
- ✅ **10 projects**
- ✅ **Auto-suspend after inactivity** (resumes on request)
- ✅ **Connection pooling**
- ✅ **Point-in-time recovery** (7 days)

### When to Upgrade?
- 📈 Storage exceeds 3GB
- 📈 Need longer backups (>7 days)
- 📈 Want dedicated compute
- 📈 Require custom domain

---

## 🔒 Security Best Practices

1. **Never commit `.env` file**
   - Already in `.gitignore`
   - Contains sensitive credentials

2. **Use environment variables**
   - Local: `.env` file
   - Production: Vercel dashboard

3. **Rotate credentials regularly**
   - Regenerate `NEXTAUTH_SECRET` monthly
   - Update Google OAuth credentials if compromised

4. **Monitor database usage**
   - Check Neon dashboard for storage
   - Set up alerts for quota limits

---

## 🆘 Troubleshooting

### Can't connect to database
```bash
# Test connection manually
npx prisma studio
```

### Migration fails
```bash
# Reset database (⚠️ deletes all data)
npx prisma migrate reset

# Then run migration again
npx prisma migrate dev --name init
```

### TypeScript errors after migration
```bash
# Regenerate Prisma client
npx prisma generate
```

### Need to change schema
1. Edit `prisma/schema.prisma`
2. Run migration:
   ```bash
   npx prisma migrate dev --name your_change_name
   ```

---

## 📚 Next Steps

✅ Database is set up!

**Now continue with:**
1. **GOOGLE_OAUTH_SETUP_GUIDE.md** - Set up Google authentication
2. **PRODUCTION_DEPLOYMENT.md** - Deploy to Vercel
3. **AUTOMATION_SCRIPTS_README.md** - Use automation scripts

---

## 🌟 Benefits of Neon vs Local PostgreSQL

| Feature | Neon | Local PostgreSQL |
|---------|------|------------------|
| Setup Time | 2 minutes | 30+ minutes |
| Maintenance | None | Manual updates |
| Backups | Automatic | Manual setup |
| Scaling | Automatic | Manual |
| Cost (Small Project) | Free | Free |
| Global Access | ✅ Yes | ❌ No |
| SSL/TLS | ✅ Built-in | Manual setup |
| Connection Pooling | ✅ Built-in | Manual setup |

---

**Made with 🤖 Claude Sonnet 4.5**  
**Developed by @workwithaaditya**  
© 2025 All rights reserved
