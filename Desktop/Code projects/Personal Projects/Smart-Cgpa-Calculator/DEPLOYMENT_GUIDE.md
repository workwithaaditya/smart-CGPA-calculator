# Smart CGPA Calculator - Complete Setup Guide

## Prerequisites

- Node.js 18+ installed
- PostgreSQL 14+ running locally or remote
- Google Cloud Console account for OAuth setup

## Step 1: Database Setup

### Install PostgreSQL (if not already installed)
```powershell
# Download from https://www.postgresql.org/download/
# Or use chocolatey:
choco install postgresql
```

### Create Database
```powershell
# Open psql
psql -U postgres

# In psql:
CREATE DATABASE smart_cgpa_db;
\q
```

## Step 2: Google OAuth Setup

1. Go to [Google Cloud Console](https://console.cloud.google.com)
2. Create a new project or select existing
3. Enable "Google+ API"
4. Go to "Credentials" → "Create Credentials" → "OAuth 2.0 Client ID"
5. Application type: **Web application**
6. Authorized redirect URIs:
   - `http://localhost:5000/auth/google/callback`
   - `http://localhost:5000/auth/google/callback/` (with trailing slash)
7. Copy **Client ID** and **Client Secret**

## Step 3: Backend Configuration

### Install Dependencies
```powershell
cd backend
npm install
```

### Configure Environment
```powershell
# Copy example env
cp .env.example .env

# Edit .env with your values:
notepad .env
```

Required values in `.env`:
```env
DATABASE_URL="postgresql://postgres:yourpassword@localhost:5432/smart_cgpa_db?schema=public"
SESSION_SECRET="generate-random-32-char-string"
GOOGLE_CLIENT_ID="your-client-id.apps.googleusercontent.com"
GOOGLE_CLIENT_SECRET="your-client-secret"
GOOGLE_CALLBACK_URL="http://localhost:5000/auth/google/callback"
PORT=5000
NODE_ENV="development"
FRONTEND_URL="http://localhost:5173,http://localhost:3000"
```

Generate SESSION_SECRET:
```powershell
# Method 1: Node.js
node -e "console.log(require('crypto').randomBytes(32).toString('base64'))"

# Method 2: PowerShell
[Convert]::ToBase64String((1..32 | ForEach-Object { Get-Random -Minimum 0 -Maximum 256 }))
```

### Initialize Database
```powershell
# Generate Prisma client
npm run generate

# Run migrations
npm run migrate
```

### Start Backend
```powershell
npm run dev
```

Backend should now be running at http://localhost:5000

## Step 4: Frontend Configuration

### Install Dependencies
```powershell
cd ..
npm install
```

### Configure Environment
```powershell
# Copy example env
cd frontend
cp .env.example .env
```

Edit `frontend/.env`:
```env
VITE_API_URL=http://localhost:5000
```

### Start Frontend
```powershell
cd ..
npm run dev
```

Frontend should now be running at http://localhost:5173 or http://localhost:3000

## Step 5: Verify Setup

### Test Backend Health
```powershell
curl http://localhost:5000/health
```

Expected response:
```json
{
  "status": "ok",
  "timestamp": "2025-11-26T...",
  "authenticated": false
}
```

### Test Frontend
1. Open http://localhost:5173
2. You should see the Smart CGPA Calculator interface
3. Click login button (if implemented)
4. You should be redirected to Google OAuth

## API Endpoints Reference

### Authentication
- `GET /auth/google` - Initiate Google OAuth
- `GET /auth/google/callback` - OAuth callback
- `GET /auth/user` - Get current user
- `GET /auth/status` - Check auth status
- `POST /auth/logout` - Logout

### Subjects
- `GET /api/subjects` - Get all subjects
- `GET /api/subjects/active` - Get active semester subjects
- `GET /api/subjects/:id` - Get single subject
- `POST /api/subjects` - Create subject
- `PUT /api/subjects/:id` - Update subject
- `PATCH /api/subjects/:id/see` - Update SEE only
- `DELETE /api/subjects/:id` - Delete subject
- `POST /api/subjects/bulk` - Bulk create
- `POST /api/subjects/recalculate` - Recalculate cached metrics

### Semesters
- `GET /api/semesters` - Get all semesters
- `GET /api/semesters/active` - Get active semester
- `POST /api/semesters` - Create semester
- `PUT /api/semesters/:id/activate` - Set active
- `DELETE /api/semesters/:id` - Delete semester

### Calculations
- `POST /api/calculate/sgpa` - Calculate SGPA
- `GET /api/calculate/cgpa` - Calculate CGPA

### Export
- `GET /api/export/json` - Export JSON
- `GET /api/export/pdf` - Download PDF

## Troubleshooting

### Database Connection Errors
```powershell
# Check PostgreSQL is running
Get-Service postgresql*

# Start if not running
Start-Service postgresql-x64-14
```

### Port Already in Use
```powershell
# Find process using port 5000
netstat -ano | findstr :5000

# Kill process (replace PID)
taskkill /PID <PID> /F
```

### OAuth Errors
- Verify redirect URI exactly matches Google Console
- Ensure both frontend and backend URLs are correct
- Check credentials are not expired

### TypeScript Errors
```powershell
# Regenerate Prisma client
cd backend
npm run generate
```

## Production Deployment Checklist

- [ ] Set NODE_ENV=production
- [ ] Use strong SESSION_SECRET
- [ ] Enable HTTPS (cookie.secure = true)
- [ ] Set proper CORS origins
- [ ] Use production database
- [ ] Enable database connection pooling
- [ ] Set up logging and monitoring
- [ ] Configure OAuth production redirect URIs
- [ ] Run database migrations: npm run migrate:deploy
- [ ] Build frontend: npm run build
- [ ] Build backend: npm run build

## User Data Persistence

### How It Works
1. **Google OAuth**: User authenticates via Google
2. **User Creation**: First login creates User record with Google ID
3. **Default Semester**: Auto-creates "Current Semester" for new users
4. **Subject Storage**: All subjects linked to userId and semesterId
5. **Session Management**: Express sessions stored in PostgreSQL
6. **Cached Metrics**: total, gp, weighted computed on save for performance

### Data Isolation
- All queries filter by userId from session
- Cascade deletes protect data integrity
- Subjects auto-link to active semester
- Each user's data completely isolated

### Memory/Storage
- PostgreSQL stores all persistent data
- Sessions expire after 30 days of inactivity
- No client-side data loss on refresh
- Subjects persist across devices

