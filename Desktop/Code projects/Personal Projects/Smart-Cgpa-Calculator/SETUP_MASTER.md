# 🚀 Smart CGPA Calculator - Complete Setup Guide

## 📋 Overview

This guide walks you through setting up the complete full-stack Smart CGPA Calculator with:
- **Frontend:** React + TypeScript + Vite + Tailwind CSS
- **Backend:** Express + Prisma + PostgreSQL
- **Authentication:** Google OAuth 2.0
- **Features:** Real-time SGPA calculation, intelligent planner, data persistence

---

## 🎯 Prerequisites

Before starting, ensure you have:

1. **Node.js 18+**
   ```powershell
   node --version  # Should be 18.0.0 or higher
   ```

2. **PostgreSQL 14+**
   - Download: https://www.postgresql.org/download/windows/
   - Or install via Chocolatey: `choco install postgresql`

3. **Google Cloud Account**
   - For OAuth 2.0 credentials
   - Free tier is sufficient

4. **Git** (optional, for version control)

---

## 📦 Part 1: Database Setup

### Step 1.1: Install PostgreSQL

If not installed:
```powershell
# Using Chocolatey
choco install postgresql

# Or download installer from postgresql.org
```

### Step 1.2: Start PostgreSQL Service

```powershell
Start-Service postgresql-x64-14
```

### Step 1.3: Create Database

Open PostgreSQL command line:
```powershell
psql -U postgres
```

In PostgreSQL shell:
```sql
CREATE DATABASE smart_cgpa_db;
\q
```

---

## 🔑 Part 2: Google OAuth Setup

### Step 2.1: Create Google Cloud Project

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Click **"Select a project"** → **"New Project"**
3. Name: `Smart CGPA Calculator`
4. Click **"Create"**

### Step 2.2: Enable Google+ API

1. In your project, go to **"APIs & Services"** → **"Library"**
2. Search for **"Google+ API"**
3. Click **"Enable"**

### Step 2.3: Configure OAuth Consent Screen

1. Go to **"APIs & Services"** → **"OAuth consent screen"**
2. Select **"External"** user type
3. Fill in:
   - App name: `Smart CGPA Calculator`
   - User support email: your-email@gmail.com
   - Developer contact: your-email@gmail.com
4. Click **"Save and Continue"**
5. Skip scopes (default is fine)
6. Add test users (your Gmail)
7. Click **"Save and Continue"**

### Step 2.4: Create OAuth Client ID

1. Go to **"APIs & Services"** → **"Credentials"**
2. Click **"Create Credentials"** → **"OAuth 2.0 Client ID"**
3. Application type: **"Web application"**
4. Name: `Smart CGPA Calculator`
5. **Authorized redirect URIs:** 
   ```
   http://localhost:5000/auth/google/callback
   ```
6. Click **"Create"**
7. **COPY** the Client ID and Client Secret (you'll need these!)

---

## ⚙️ Part 3: Backend Setup

### Step 3.1: Navigate to Backend

```powershell
cd "c:\Users\rsneg\Desktop\Code projects\Personal Projects\Smart-Cgpa-Calculator\backend"
```

### Step 3.2: Install Dependencies

```powershell
npm install
```

This installs:
- Express (web server)
- Prisma (ORM)
- Passport (authentication)
- PostgreSQL drivers
- TypeScript support

### Step 3.3: Configure Environment

Copy example environment file:
```powershell
Copy-Item .env.example .env
```

Edit `.env` with your values:
```powershell
notepad .env
```

Update these values:
```env
DATABASE_URL="postgresql://postgres:YOUR_POSTGRES_PASSWORD@localhost:5432/smart_cgpa_db?schema=public"
SESSION_SECRET="YOUR_RANDOM_SECRET_HERE"
GOOGLE_CLIENT_ID="your-google-client-id.apps.googleusercontent.com"
GOOGLE_CLIENT_SECRET="your-google-client-secret"
GOOGLE_CALLBACK_URL="http://localhost:5000/auth/google/callback"
PORT=5000
NODE_ENV="development"
FRONTEND_URL="http://localhost:3000"
```

**Generate SESSION_SECRET:**
```powershell
node -e "console.log(require('crypto').randomBytes(32).toString('base64'))"
```

### Step 3.4: Setup Database Schema

Generate Prisma Client:
```powershell
npm run generate
```

Run migrations to create tables:
```powershell
npm run migrate
```

You should see:
```
✓ Generated Prisma Client
✓ Your database is now in sync with your schema
```

### Step 3.5: Start Backend Server

```powershell
npm run dev
```

You should see:
```
✓ Server running on http://localhost:5000
✓ Environment: development
```

**Keep this terminal open!**

---

## 🎨 Part 4: Frontend Setup

### Step 4.1: Open New Terminal

Open a new PowerShell window (keep backend running in the first one).

### Step 4.2: Navigate to Frontend

```powershell
cd "c:\Users\rsneg\Desktop\Code projects\Personal Projects\Smart-Cgpa-Calculator\frontend"
```

### Step 4.3: Install Dependencies

```powershell
npm install
```

This installs:
- React 18
- TypeScript
- Vite
- Tailwind CSS
- Recharts
- Testing libraries

### Step 4.4: Start Frontend Dev Server

```powershell
npm run dev
```

You should see:
```
  VITE v5.0.0  ready in 500 ms

  ➜  Local:   http://localhost:3000/
```

---

## ✅ Part 5: Test the Application

### Step 5.1: Open Browser

Navigate to: `http://localhost:3000`

### Step 5.2: Login Flow

1. You should see the **Login Page**
2. Click **"Continue with Google"**
3. Select your Google account
4. Authorize the application
5. You'll be redirected back to the app

### Step 5.3: Test Features

**1. View Dashboard**
- See SGPA stats cards
- View your subjects (or sample data)

**2. Adjust SEE Marks**
- Drag the slider on any subject
- Watch SGPA update in real-time
- Changes automatically save to backend

**3. Add Subject**
- Click **"+ Add Subject"**
- New subject appears
- Saved to database automatically

**4. Remove Subject**
- Click **"Remove"** on any subject card
- Subject deleted from UI and database

**5. View Charts**
- See grade distribution
- View impact analysis
- Check optimization suggestions

**6. Test Planner**
- Click **"Show Planner"**
- Enter target SGPA
- Get recommended SEE scores

**7. Export Data**
- Click **"Export JSON"** - Download data file
- Click **"Export PDF"** - Download visual report

**8. Test Persistence**
- Make changes to subjects
- Click logout
- Login again
- **Your data should be preserved!**

---

## 🎯 Project Structure

```
Smart-Cgpa-Calculator/
├── backend/                          # Express + Prisma backend
│   ├── src/
│   │   ├── server.ts                # Main server entry
│   │   ├── auth/
│   │   │   └── passport-config.ts   # Google OAuth
│   │   ├── middleware/
│   │   │   └── auth.ts              # Auth middleware
│   │   └── routes/
│   │       ├── auth.ts              # Login/logout
│   │       ├── subjects.ts          # Subject CRUD
│   │       ├── semesters.ts         # Semester management
│   │       └── calculations.ts      # SGPA calculations
│   ├── prisma/
│   │   └── schema.prisma            # Database schema
│   ├── package.json
│   ├── .env                         # Environment config (create this)
│   └── SETUP.md                     # Backend-specific guide
│
├── frontend/                         # React + TypeScript app
│   ├── src/
│   │   ├── lib/
│   │   │   ├── SGPAEngine.ts        # Calculation engine
│   │   │   └── apiClient.ts         # Backend API client
│   │   ├── contexts/
│   │   │   └── AuthContext.tsx      # Auth state
│   │   ├── components/
│   │   │   ├── SubjectCard.tsx      # Subject display
│   │   │   ├── SubjectSlider.tsx    # Interactive slider
│   │   │   ├── Charts.tsx           # Visualizations
│   │   │   ├── Planner.tsx          # Grade planner
│   │   │   ├── Header.tsx           # User header
│   │   │   └── ProtectedRoute.tsx   # Route guard
│   │   ├── pages/
│   │   │   └── LoginPage.tsx        # Login screen
│   │   ├── App.tsx                  # Main app component
│   │   └── index.tsx                # Entry point
│   ├── tests/
│   │   └── sgpa.test.ts             # Unit tests
│   ├── package.json
│   ├── .env                         # Frontend config
│   └── INTEGRATION.md               # Integration guide
│
└── SETUP_MASTER.md                   # This file!
```

---

## 🐛 Troubleshooting

### Backend Won't Start

**Error: Cannot connect to database**
```powershell
# Check PostgreSQL is running
Get-Service postgresql*

# Start if stopped
Start-Service postgresql-x64-14

# Test connection
psql -U postgres -d smart_cgpa_db
```

**Error: Port 5000 already in use**
```powershell
# Find process on port 5000
netstat -ano | findstr :5000

# Kill process (replace <PID>)
taskkill /PID <PID> /F
```

**Error: Missing environment variables**
- Check `.env` file exists in backend folder
- Verify all values are filled in
- No quotes around values
- No trailing spaces

### Frontend Won't Start

**Error: Port 3000 already in use**
```powershell
# Kill process on port 3000
netstat -ano | findstr :3000
taskkill /PID <PID> /F
```

**Error: Module not found**
```powershell
# Reinstall dependencies
rm -r node_modules
rm package-lock.json
npm install
```

### OAuth Errors

**Error: redirect_uri_mismatch**
- Go to Google Cloud Console
- Check redirect URI is exactly: `http://localhost:5000/auth/google/callback`
- No trailing slash
- Must be `http` not `https` for localhost

**Error: OAuth client not found**
- Verify `GOOGLE_CLIENT_ID` in backend `.env`
- Verify `GOOGLE_CLIENT_SECRET` in backend `.env`
- Make sure no extra spaces or quotes

**Error: Access denied**
- Add your Gmail as a test user in OAuth consent screen
- Make sure you're logging in with the test user account

### Data Not Persisting

**Check backend is running**
```powershell
curl http://localhost:5000/health
```

**Check authentication**
```powershell
curl http://localhost:5000/auth/status
```

**View database**
```powershell
cd backend
npm run studio
```
Opens Prisma Studio at `http://localhost:5555`

---

## 📊 API Endpoints Reference

### Authentication
- `GET /auth/status` - Check login status
- `GET /auth/google` - Start OAuth flow
- `GET /auth/google/callback` - OAuth redirect
- `GET /auth/user` - Get user details
- `POST /auth/logout` - End session

### Subjects
- `GET /api/subjects` - All subjects
- `GET /api/subjects/active` - Active semester
- `POST /api/subjects` - Create subject
- `PUT /api/subjects/:id` - Update subject
- `PATCH /api/subjects/:id/see` - Update SEE only
- `DELETE /api/subjects/:id` - Delete subject
- `POST /api/subjects/bulk` - Bulk create

### Semesters
- `GET /api/semesters` - All semesters
- `GET /api/semesters/active` - Active semester
- `POST /api/semesters` - Create semester
- `PUT /api/semesters/:id/activate` - Set active
- `DELETE /api/semesters/:id` - Delete semester

### Calculations
- `POST /api/calculate/sgpa` - Calculate SGPA

---

## 🔒 Security Checklist

- [ ] Strong SESSION_SECRET generated
- [ ] PostgreSQL password is secure
- [ ] `.env` files not committed to git
- [ ] Google OAuth redirect URI matches exactly
- [ ] Test users added to OAuth consent screen
- [ ] CORS restricted to frontend URL
- [ ] Cookies set to HttpOnly
- [ ] Session data stored in database, not memory

---

## 🎉 Success Checklist

- [ ] PostgreSQL installed and running
- [ ] Database `smart_cgpa_db` created
- [ ] Google OAuth credentials obtained
- [ ] Backend `.env` configured
- [ ] Backend dependencies installed
- [ ] Prisma migrations run
- [ ] Backend server running on :5000
- [ ] Frontend `.env` configured
- [ ] Frontend dependencies installed
- [ ] Frontend server running on :3000
- [ ] Can access login page
- [ ] Google login works
- [ ] Dashboard loads
- [ ] Subjects display
- [ ] SEE changes sync
- [ ] Add/remove subject works
- [ ] Charts display correctly
- [ ] Planner calculates targets
- [ ] Export features work
- [ ] Logout works
- [ ] Data persists after logout/login

---

## 📚 Additional Documentation

- **Backend Details:** `backend/SETUP.md`
- **Frontend Integration:** `frontend/INTEGRATION.md`
- **Project Overview:** `frontend/docs/README.md`
- **Quick Start:** `frontend/docs/QUICKSTART.md`
- **UI Reference:** `frontend/docs/UI-REFERENCE.md`
- **API Examples:** `frontend/docs/example-payloads.md`

---

## 🚀 Next Steps

### For Development
1. Run tests: `cd frontend && npm test`
2. View database: `cd backend && npm run studio`
3. Check API docs: `frontend/docs/example-payloads.md`

### For Production
1. Set `NODE_ENV=production` in backend `.env`
2. Build frontend: `cd frontend && npm run build`
3. Use HTTPS with SSL certificates
4. Use production PostgreSQL instance
5. Set secure `FRONTEND_URL` in backend `.env`
6. Enable rate limiting (add express-rate-limit)
7. Add monitoring (PM2, logs)

---

## 💡 Tips

1. **Keep Both Terminals Open**
   - Terminal 1: Backend (port 5000)
   - Terminal 2: Frontend (port 3000)

2. **Use Prisma Studio**
   - Visual database browser
   - Run: `cd backend && npm run studio`
   - View/edit data directly

3. **Check Logs**
   - Backend logs errors to console
   - Frontend logs to browser console
   - Use F12 in browser for dev tools

4. **Restart After .env Changes**
   - Stop servers (Ctrl+C)
   - Restart both backend and frontend

---

## 🎊 Congratulations!

You now have a fully functional, production-ready Smart CGPA Calculator with:
- ✅ Google OAuth 2.0 authentication
- ✅ PostgreSQL database with Prisma ORM
- ✅ Real-time SGPA calculations
- ✅ Interactive grade visualization
- ✅ Intelligent grade planning
- ✅ Per-user data isolation
- ✅ Multi-semester support
- ✅ Beautiful, responsive UI
- ✅ Complete test coverage
- ✅ Professional documentation

**Enjoy calculating your grades! 🎓📊**
