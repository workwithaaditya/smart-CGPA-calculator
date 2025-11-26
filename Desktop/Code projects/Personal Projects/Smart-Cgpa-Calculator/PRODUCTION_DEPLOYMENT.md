# 🚀 Production Deployment Checklist

## Your Deployment URLs

- **Frontend**: https://smart-cgpa-calculator-kohl.vercel.app/
- **Backend**: (Need to deploy separately)

---

## ✅ Deployment Steps

### 1. Update Google OAuth for Production

Go to [Google Cloud Console Credentials](https://console.cloud.google.com/apis/credentials)

1. Click on your OAuth 2.0 Client ID
2. Add to **Authorized JavaScript origins**:
   ```
   https://smart-cgpa-calculator-kohl.vercel.app
   ```

3. Add to **Authorized redirect URIs**:
   ```
   https://your-backend-url.vercel.app/auth/google/callback
   ```
   (Replace with actual backend URL after deployment)

4. Click **SAVE**

---

### 2. Deploy Backend to Vercel

#### Option A: Via Vercel Dashboard

1. Go to https://vercel.com/new
2. Import your GitHub repository: `workwithaaditya/smart-CGPA-calculator`
3. **Root Directory**: Set to `backend`
4. **Framework Preset**: Other
5. **Build Command**: `npm run build`
6. **Output Directory**: `dist`
7. **Install Command**: `npm install`

#### Option B: Via CLI

```bash
cd backend
vercel --prod
```

---

### 3. Set Environment Variables in Backend Vercel Project

Go to your backend Vercel project → Settings → Environment Variables

Add these variables:

| Variable | Value | Notes |
|----------|-------|-------|
| `DATABASE_URL` | `postgresql://...` | Get from Supabase or Vercel Postgres |
| `SESSION_SECRET` | `your-random-32-char-secret` | Use the one from setup script |
| `GOOGLE_CLIENT_ID` | `xxx.apps.googleusercontent.com` | From Google Cloud Console |
| `GOOGLE_CLIENT_SECRET` | `GOCSPX-xxx` | From Google Cloud Console |
| `GOOGLE_CALLBACK_URL` | `https://your-backend.vercel.app/auth/google/callback` | Your backend URL |
| `FRONTEND_URL` | `https://smart-cgpa-calculator-kohl.vercel.app` | Your frontend URL |
| `NODE_ENV` | `production` | Production mode |

**Select**: All environments (Production, Preview, Development)

---

### 4. Set Frontend Environment Variable

Go to your frontend Vercel project → Settings → Environment Variables

Add:

| Variable | Value |
|----------|-------|
| `VITE_API_URL` | `https://your-backend-url.vercel.app` |

Then **redeploy** the frontend.

---

### 5. Set Up Production Database

#### Option A: Vercel Postgres (Recommended for Vercel)

1. Go to Vercel Dashboard → Storage → Create Database
2. Select **Postgres**
3. Name: `smart-cgpa-db`
4. Click **Create**
5. Copy the `DATABASE_URL` (under `.env.local` tab)
6. Add to backend environment variables

#### Option B: Supabase (Free Alternative)

1. Go to https://supabase.com/dashboard
2. Create new project: `smart-cgpa-db`
3. Choose region (closest to your users)
4. Set database password
5. Wait 2-3 minutes for setup
6. Go to Settings → Database
7. Copy connection string (Transaction mode)
8. Add to backend environment variables

---

### 6. Run Database Migrations

After backend is deployed:

```bash
# If using Vercel Postgres - run migrations via Vercel CLI
cd backend
vercel env pull  # Download environment variables
npx prisma migrate deploy

# If using Supabase - run locally then push
npx prisma migrate deploy
```

Or manually in Vercel dashboard:
- Go to Functions tab
- Add a script: `npx prisma migrate deploy`

---

### 7. Update OAuth Redirect URIs (After Backend Deployed)

Once you know your backend URL:

1. Go to Google Cloud Console → Credentials
2. Edit OAuth client
3. Update redirect URI to actual backend URL:
   ```
   https://your-actual-backend.vercel.app/auth/google/callback
   ```
4. Save

---

### 8. Test Production Flow

1. Visit https://smart-cgpa-calculator-kohl.vercel.app/
2. App should load (works without login)
3. Click **"Sign In"** button
4. Should redirect to Google OAuth
5. After login, should return to app
6. Your name/avatar should appear
7. Add subjects - should sync to database
8. Open in different browser/device - data should persist

---

## 🔍 Verification Checklist

- [ ] Frontend loads at production URL
- [ ] Backend responds to health check
- [ ] Google OAuth redirects work
- [ ] Sign in completes successfully
- [ ] User data persists after refresh
- [ ] Sign out works correctly
- [ ] Data syncs across devices
- [ ] No console errors

---

## 🐛 Common Issues

### "redirect_uri_mismatch" Error
- Verify redirect URI in Google Console matches exactly
- Check for trailing slashes
- Ensure using HTTPS in production

### Backend CORS Error
- Check `FRONTEND_URL` environment variable
- Verify CORS settings in `server.ts`

### Database Connection Error
- Verify `DATABASE_URL` is correct
- Check database allows connections from Vercel IPs
- Ensure migrations ran successfully

### Session Not Persisting
- Check `SESSION_SECRET` is set
- Verify `NODE_ENV=production`
- Check cookie settings for HTTPS

---

## 📊 Current Status

**Frontend**: ✅ Deployed
- URL: https://smart-cgpa-calculator-kohl.vercel.app/
- Status: Live
- Works: Offline mode (localStorage)

**Backend**: ⏳ Needs deployment
- Once deployed, authentication will work
- Database persistence will activate

---

## 🎯 Next Immediate Steps

1. **Deploy backend** to Vercel
2. **Set up database** (Vercel Postgres or Supabase)
3. **Add environment variables** to Vercel
4. **Update Google OAuth** with production URLs
5. **Test sign-in flow**

---

**Deployment Guide**: See `backend/VERCEL_DEPLOYMENT.md` for detailed instructions

**Built by Aaditya** 🚀
