# ✅ Backend + Frontend Integration Checklist

## 📋 Setup Verification

### Backend Files Created ✅
- [x] `backend/package.json` - Dependencies manifest
- [x] `backend/tsconfig.json` - TypeScript configuration
- [x] `backend/.env.example` - Environment template
- [x] `backend/prisma/schema.prisma` - Database schema
- [x] `backend/src/server.ts` - Main Express server
- [x] `backend/src/auth/passport-config.ts` - OAuth strategy
- [x] `backend/src/middleware/auth.ts` - Auth middleware
- [x] `backend/src/routes/auth.ts` - Auth endpoints
- [x] `backend/src/routes/subjects.ts` - Subject CRUD
- [x] `backend/src/routes/semesters.ts` - Semester management
- [x] `backend/src/routes/calculations.ts` - SGPA API
- [x] `backend/SETUP.md` - Setup documentation

### Frontend Files Created/Updated ✅
- [x] `frontend/src/lib/apiClient.ts` - API client
- [x] `frontend/src/contexts/AuthContext.tsx` - Auth context
- [x] `frontend/src/pages/LoginPage.tsx` - Login UI
- [x] `frontend/src/components/Header.tsx` - User header
- [x] `frontend/src/components/ProtectedRoute.tsx` - Route guard
- [x] `frontend/src/vite-env.d.ts` - Environment types
- [x] `frontend/.env` - Frontend config
- [x] `frontend/src/index.tsx` - Updated entry point
- [x] `frontend/src/App.tsx` - Backend integration
- [x] `frontend/INTEGRATION.md` - Integration guide

### Documentation Created ✅
- [x] `backend/SETUP.md` - Backend setup guide
- [x] `frontend/INTEGRATION.md` - Frontend integration
- [x] `SETUP_MASTER.md` - Complete setup guide
- [x] `PROJECT_COMPLETE.md` - Project summary
- [x] `README.md` - Updated with auth section
- [x] `CHECKLIST_INTEGRATION.md` - This file

---

## 🎯 Before You Run

### Prerequisites Needed
- [ ] Node.js 18+ installed
- [ ] PostgreSQL 14+ installed
- [ ] Google Cloud account created
- [ ] Git installed (optional)

### Google OAuth Setup Required
- [ ] Google Cloud project created
- [ ] Google+ API enabled
- [ ] OAuth consent screen configured
- [ ] OAuth Client ID created
- [ ] Redirect URI added: `http://localhost:5000/auth/google/callback`
- [ ] Client ID copied
- [ ] Client Secret copied

### Database Setup Required
- [ ] PostgreSQL service running
- [ ] Database `smart_cgpa_db` created
- [ ] PostgreSQL password known

---

## 🔧 Installation Steps

### Backend Setup
- [ ] Navigate to `backend/` folder
- [ ] Run `npm install`
- [ ] Copy `.env.example` to `.env`
- [ ] Edit `.env` with your values:
  - [ ] `DATABASE_URL` configured
  - [ ] `SESSION_SECRET` generated
  - [ ] `GOOGLE_CLIENT_ID` added
  - [ ] `GOOGLE_CLIENT_SECRET` added
- [ ] Run `npm run generate` (Prisma Client)
- [ ] Run `npm run migrate` (Database schema)
- [ ] Run `npm run dev` (Start server)
- [ ] Verify: `http://localhost:5000/health` works

### Frontend Setup
- [ ] Open new terminal
- [ ] Navigate to `frontend/` folder
- [ ] Run `npm install` (if not done)
- [ ] Verify `.env` exists with `VITE_API_URL=http://localhost:5000`
- [ ] Run `npm run dev` (Start server)
- [ ] Verify: `http://localhost:3000` opens

---

## 🧪 Testing Steps

### Authentication Flow
- [ ] Open `http://localhost:3000`
- [ ] See login page
- [ ] Click "Continue with Google"
- [ ] Redirects to Google login
- [ ] Select Google account
- [ ] Authorize app
- [ ] Redirects back to app
- [ ] Dashboard loads
- [ ] Header shows user name/picture

### Data Persistence
- [ ] Dashboard shows subjects (or sample data)
- [ ] Adjust SEE slider on a subject
- [ ] SGPA updates in real-time
- [ ] Click "Add Subject"
- [ ] New subject appears
- [ ] Click "Remove" on a subject
- [ ] Subject disappears
- [ ] Click Logout
- [ ] Login again
- [ ] **Data should be preserved!**

### Features
- [ ] Stats cards show correct values
- [ ] Charts display properly
- [ ] Click "Show Planner"
- [ ] Enter target SGPA
- [ ] Get recommendations
- [ ] Click "Export JSON"
- [ ] JSON file downloads
- [ ] Click "Export PDF"
- [ ] PDF file downloads

---

## 🐛 Common Issues & Solutions

### Backend Won't Start

**Problem:** `Cannot connect to database`
```powershell
# Check PostgreSQL service
Get-Service postgresql*

# Start if stopped
Start-Service postgresql-x64-14

# Test connection
psql -U postgres -d smart_cgpa_db
```

**Problem:** `Port 5000 already in use`
```powershell
# Find and kill process
netstat -ano | findstr :5000
taskkill /PID <PID> /F
```

**Problem:** `Missing environment variables`
- Verify `.env` file exists in `backend/`
- Check all values are filled
- No quotes around values
- Run: `cat .env` to verify

### Frontend Won't Start

**Problem:** `Port 3000 already in use`
```powershell
# Kill process
netstat -ano | findstr :3000
taskkill /PID <PID> /F
```

**Problem:** `Cannot find module`
```powershell
# Reinstall dependencies
rm -r node_modules
rm package-lock.json
npm install
```

### OAuth Errors

**Problem:** `redirect_uri_mismatch`
- Go to Google Cloud Console → Credentials
- Edit OAuth Client ID
- Verify redirect URI: `http://localhost:5000/auth/google/callback`
- Must be exactly this (no trailing slash)
- Must be `http` not `https` for localhost

**Problem:** `invalid_client`
- Check `GOOGLE_CLIENT_ID` in backend `.env`
- Check `GOOGLE_CLIENT_SECRET` in backend `.env`
- Verify no extra spaces or quotes
- Copy values directly from Google Cloud Console

**Problem:** `Access blocked`
- Go to OAuth consent screen
- Add your Gmail as test user
- Make sure app is not in production mode

### Data Not Syncing

**Problem:** Changes don't persist
```powershell
# Test backend is running
curl http://localhost:5000/health

# Check auth status
curl http://localhost:5000/auth/status

# View logs
# Check terminal where backend is running for errors
```

**Problem:** "Not authenticated" error
- Make sure you're logged in
- Check cookies are enabled in browser
- Try incognito mode
- Clear browser cookies and login again

---

## 📊 Database Verification

### View Data in Prisma Studio
```powershell
cd backend
npm run studio
```

Opens: `http://localhost:5555`

**Check:**
- [ ] User table has your Google account
- [ ] Semester table has at least one semester
- [ ] Subject table has your subjects
- [ ] Session table has active session

### Manual Database Check
```powershell
psql -U postgres -d smart_cgpa_db

# Check tables exist
\dt

# Check users
SELECT email, name FROM "User";

# Check subjects
SELECT code, name, cie, see FROM "Subject";

# Exit
\q
```

---

## 🎯 Feature Verification

### Authentication ✅
- [ ] Login with Google works
- [ ] User info displays in header
- [ ] Logout clears session
- [ ] Cannot access app without login
- [ ] Login redirects to dashboard

### Subject Management ✅
- [ ] Can create new subject
- [ ] Can update SEE marks
- [ ] Can delete subject
- [ ] Changes persist after refresh
- [ ] Changes persist after logout/login

### Calculations ✅
- [ ] SGPA calculates correctly
- [ ] Stats cards update in real-time
- [ ] Grade boundaries show on slider
- [ ] Toast notifications on grade change
- [ ] Charts display correct data

### Planner ✅
- [ ] Can enter target SGPA
- [ ] Gets subject-wise recommendations
- [ ] Shows feasibility status
- [ ] Recommendations are accurate

### Export ✅
- [ ] JSON export downloads file
- [ ] JSON contains all data
- [ ] PDF export generates visual report
- [ ] PDF includes charts and stats

### UI/UX ✅
- [ ] Smooth animations
- [ ] Loading states show
- [ ] Sync indicator appears
- [ ] Error messages display
- [ ] Responsive on mobile
- [ ] Keyboard shortcuts work
- [ ] High contrast mode works

---

## 🚀 Performance Verification

### Load Times
- [ ] Initial load < 2 seconds
- [ ] Login redirect < 1 second
- [ ] Subject update < 500ms
- [ ] Chart render < 1 second

### Backend Response Times
```powershell
# Test API endpoints
curl -w "\nTime: %{time_total}s\n" http://localhost:5000/health
curl -w "\nTime: %{time_total}s\n" http://localhost:5000/auth/status
```

Should be < 100ms for most requests

---

## 📁 File Structure Verification

```
Smart-Cgpa-Calculator/
├── backend/
│   ├── src/
│   │   ├── server.ts ✅
│   │   ├── auth/
│   │   │   └── passport-config.ts ✅
│   │   ├── middleware/
│   │   │   └── auth.ts ✅
│   │   └── routes/
│   │       ├── auth.ts ✅
│   │       ├── subjects.ts ✅
│   │       ├── semesters.ts ✅
│   │       └── calculations.ts ✅
│   ├── prisma/
│   │   └── schema.prisma ✅
│   ├── package.json ✅
│   ├── tsconfig.json ✅
│   ├── .env.example ✅
│   ├── .env (you create) ⚠️
│   └── SETUP.md ✅
│
├── frontend/
│   ├── src/
│   │   ├── lib/
│   │   │   ├── SGPAEngine.ts ✅
│   │   │   └── apiClient.ts ✅
│   │   ├── contexts/
│   │   │   └── AuthContext.tsx ✅
│   │   ├── components/
│   │   │   ├── Header.tsx ✅
│   │   │   ├── ProtectedRoute.tsx ✅
│   │   │   ├── SubjectCard.tsx ✅
│   │   │   ├── SubjectSlider.tsx ✅
│   │   │   ├── Charts.tsx ✅
│   │   │   └── Planner.tsx ✅
│   │   ├── pages/
│   │   │   └── LoginPage.tsx ✅
│   │   ├── vite-env.d.ts ✅
│   │   ├── App.tsx ✅ (updated)
│   │   └── index.tsx ✅ (updated)
│   ├── tests/
│   │   └── sgpa.test.ts ✅
│   ├── docs/ ✅ (7 files)
│   ├── .env ✅
│   └── INTEGRATION.md ✅
│
├── SETUP_MASTER.md ✅
├── PROJECT_COMPLETE.md ✅
├── README.md ✅ (updated)
└── CHECKLIST_INTEGRATION.md ✅ (this file)
```

---

## 📝 Environment Variables Checklist

### Backend `.env`
```env
DATABASE_URL="postgresql://postgres:PASSWORD@localhost:5432/smart_cgpa_db?schema=public"
SESSION_SECRET="<32-byte random string>"
GOOGLE_CLIENT_ID="<your-id>.apps.googleusercontent.com"
GOOGLE_CLIENT_SECRET="<your-secret>"
GOOGLE_CALLBACK_URL="http://localhost:5000/auth/google/callback"
PORT=5000
NODE_ENV="development"
FRONTEND_URL="http://localhost:3000"
```

### Frontend `.env`
```env
VITE_API_URL=http://localhost:5000
```

---

## 🎊 Final Verification

### All Systems Go ✅
- [ ] PostgreSQL running
- [ ] Backend running on :5000
- [ ] Frontend running on :3000
- [ ] Can login with Google
- [ ] Data persists
- [ ] All features work
- [ ] Tests pass
- [ ] Documentation complete

### Ready for Demo ✅
- [ ] Clean browser cookies
- [ ] Test full login flow
- [ ] Add sample subjects
- [ ] Show SGPA calculations
- [ ] Demo planner
- [ ] Export reports
- [ ] Logout and login again to show persistence

---

## 🎯 What to Do Next

### 1. Get It Running (15 minutes)
- Follow `SETUP_MASTER.md` step by step
- Install PostgreSQL
- Get Google OAuth credentials
- Setup backend and frontend
- Test login flow

### 2. Customize (Optional)
- Add your name to `README.md`
- Customize branding/colors
- Add more subjects
- Modify grade boundaries
- Add additional features

### 3. Deploy (Optional)
- Choose hosting platform (Heroku, Vercel, Railway)
- Setup production database
- Configure production OAuth
- Deploy backend and frontend
- Test production environment

### 4. Share
- Push to GitHub
- Add to portfolio
- Share with friends
- Get feedback
- Iterate and improve

---

## 📞 Need Help?

1. **Check Documentation**
   - `SETUP_MASTER.md` - Complete guide
   - `backend/SETUP.md` - Backend details
   - `frontend/INTEGRATION.md` - Frontend details

2. **Troubleshooting**
   - See "Common Issues" section above
   - Check both terminal logs
   - Use browser dev tools (F12)
   - Verify `.env` files

3. **Database Issues**
   - Use Prisma Studio: `npm run studio`
   - Check PostgreSQL logs
   - Verify connection string

4. **OAuth Issues**
   - Double-check redirect URI
   - Verify credentials
   - Check test user list
   - Try incognito mode

---

## ✨ Success Indicators

You know it's working when:

✅ Login page loads with Google button  
✅ Clicking login redirects to Google  
✅ After authorization, dashboard loads  
✅ Header shows your name and picture  
✅ Can add/remove subjects  
✅ SEE slider changes update SGPA  
✅ After logout and login, data is still there  
✅ Charts display correctly  
✅ Planner gives recommendations  
✅ Export downloads files  

---

**🎉 Congratulations! Your full-stack Smart CGPA Calculator is ready!**

**Start here:** Open `SETUP_MASTER.md` and follow the guide step-by-step.
