# 🎓 Smart CGPA Calculator

> **A modern, full-stack web application for tracking and optimizing academic performance with real-time SGPA calculation, intelligent planning, and cloud sync.**

![Version](https://img.shields.io/badge/version-2.0.0-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)
![React](https://img.shields.io/badge/React-18.3-61dafb.svg)
![TypeScript](https://img.shields.io/badge/TypeScript-5.3-3178c6.svg)
![Express](https://img.shields.io/badge/Express-4.18-000000.svg)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Neon-336791.svg)

**Live Demo**: [Try it now!](https://your-deployed-url.vercel.app)

---

## 🌟 Overview

Smart CGPA Calculator is a powerful academic performance management tool designed for engineering students. Track your SGPA/CGPA in real-time, plan target scores, visualize performance analytics, and export detailed reports—all with a beautiful, intuitive interface.

### Why Smart CGPA Calculator?

- **📊 Live SGPA Updates** - See your SGPA change instantly as you adjust marks
- **🎯 Intelligent Planning** - Get actionable recommendations to reach your target SGPA
- **📈 Visual Analytics** - Charts and graphs to understand your performance trends
- **☁️ Cloud Sync** - Optional Google login to sync data across all devices
- **🔒 Privacy First** - Works completely offline; login only if you want sync
- **📱 Mobile Friendly** - Responsive design works perfectly on any device
- **⚡ Lightning Fast** - Optimized performance with debounced sync and memoization

---

## ✨ Key Features

### 🔐 Authentication & Data Management
- **Local-First Architecture** - Works instantly without login, data saved in browser
- **Google OAuth 2.0** - Optional secure login for cloud sync
- **Automatic Sync** - Changes sync to cloud automatically when logged in
- **Session Management** - Persistent sessions with PostgreSQL (Neon)
- **Data Privacy** - Complete data isolation per user

### 📊 Grade Calculation & Tracking
- **Real-time SGPA** - Instant calculation as you modify marks
- **Subject Grouping** - Organized by credits for better visibility
- **Live Updates** - Dynamic color-coded SGPA indicator (green/blue/purple/amber/red)
- **Credit Management** - Track total credits and weighted grade points
- **Max SGPA Calculation** - See your maximum achievable SGPA

### 🎯 Intelligent Planner
- **Target Setting** - Set your desired SGPA goal
- **Smart Recommendations** - Get per-subject SEE targets to reach your goal
- **Optimized Strategy** - Greedy algorithm suggests which subjects to focus on first
- **Feasibility Check** - Instantly know if your target is achievable
- **What-If Analysis** - Simulate different score scenarios

### 📈 Advanced Analytics
- **Subject Performance Charts** - Visualize grade distribution
- **SGPA Trend Analysis** - Track performance across subjects
- **Interactive Graphs** - Explore how marks affect your SGPA
- **Impact Analysis** - See which subjects have the most weight

### 🎨 Modern UI/UX
- **Beautiful Design** - Clean, gradient-rich dark theme
- **Smooth Animations** - Framer Motion powered transitions
- **Interactive Sliders** - Adjust SEE marks with responsive sliders
- **Responsive Layout** - Perfect on desktop, tablet, and mobile
- **Sticky SGPA Display** - Always visible at the top
- **Modal Forms** - Intuitive subject add/edit experience

### 📤 Export & Share
- **JSON Export** - Download your complete data as JSON
- **PDF Reports** - Generate printable PDF reports with html2canvas
- **Share Ready** - Formatted for easy sharing with advisors or parents

---

## 🛠️ Tech Stack

### Frontend
- **React 18** - Modern UI library with hooks
- **TypeScript** - Type-safe development
- **Vite** - Lightning-fast build tool
- **Tailwind CSS** - Utility-first styling
- **Framer Motion** - Smooth animations
- **Lucide React** - Beautiful icons
- **html2canvas** - PDF generation
- **jsPDF** - PDF export

### Backend
- **Node.js** - JavaScript runtime
- **Express.js** - Web framework
- **TypeScript** - Type safety
- **Passport.js** - Google OAuth authentication
- **Prisma** - Modern ORM
- **PostgreSQL (Neon)** - Cloud database
- **express-session** - Session management

### DevOps & Deployment
- **Vercel** - Frontend hosting (recommended)
- **Vercel** - Backend hosting (serverless functions)
- **Neon** - Serverless PostgreSQL
- **GitHub Actions** - CI/CD (optional)

---

## 📐 Calculation Methodology

### SGPA Formula

```
1. Scale SEE marks (out of 100) to 50:
   SEE_scaled = SEE / 2

2. Calculate total marks for subject:
   Total = CIE + SEE_scaled  (range: 0-100)

3. Map total to Grade Point (GP):
   90-100 → GP 10 (O - Outstanding)
   80-89  → GP 9  (A+ - Excellent)
   70-79  → GP 8  (A - Very Good)
   60-69  → GP 7  (B+ - Good)
   50-59  → GP 6  (B - Above Average)
   40-49  → GP 5  (C - Average)
   0-39   → GP 4  (F - Fail)

4. Calculate weighted points for each subject:
   WeightedPoints = GP × Credits

5. Calculate SGPA:
   SGPA = Σ(WeightedPoints) / Σ(Credits)
```

### Example Calculation

**Subject:** Data Structures using C
- **CIE:** 40
- **SEE:** 80
- **Credits:** 4

**Step 1:** SEE_scaled = 80 / 2 = 40  
**Step 2:** Total = 40 + 40 = 80  
**Step 3:** Total 80 → GP = 9 (A+)  
**Step 4:** WeightedPoints = 9 × 4 = 36  

If this is your only subject:
**SGPA = 36 / 4 = 9.00**

---

## 🎯 Planner Algorithm

The planner uses a **greedy algorithm** to recommend optimal SEE targets:

### For Target SGPA

```typescript
1. Calculate required total weighted points:
   Required = TargetSGPA × TotalCredits

2. For each subject, find minimum SEE to reach next grade:
   For each grade cutoff (starting from current grade):
     SEE_needed = (cutoff_total - CIE) × 2
     If SEE_needed is achievable (0-100):
       Calculate new SGPA with this SEE
       If new SGPA >= Target:
         Recommend this SEE

3. If target is unreachable:
   Calculate maximum achievable SGPA with all SEE = 100
   Show "Best possible: X.XX"
```

### Strategy Ranking

Subjects are ranked by **marginal gain** - which gives the most SGPA boost per mark:

```
MarginalGain = (Credits × ΔGP) / ΔMarks
```

Where:
- `ΔGP` = Grade point increase from current to next grade
- `ΔMarks` = SEE marks needed to reach next grade
- Higher ratio = better return on investment

---

## 📁 Project Structure

```
smart-CGPA-calculator/
│
├── frontend/                    # React frontend application
│   ├── src/
│   │   ├── App.tsx             # Main app component
│   │   ├── index.tsx           # Entry point
│   │   ├── components/
│   │   │   ├── SubjectCard.tsx # Subject display with slider
│   │   │   ├── Charts.tsx      # Analytics visualizations
│   │   │   ├── Planner.tsx     # Target planner component
│   │   │   └── Header.tsx      # App header with auth
│   │   ├── contexts/
│   │   │   └── AuthContext.tsx # Authentication context
│   │   ├── lib/
│   │   │   ├── SGPAEngine.ts   # Core calculation logic
│   │   │   └── apiClient.ts    # API communication
│   │   ├── services/
│   │   │   └── api.ts          # Backend API calls
│   │   └── styles/
│   │       └── index.css       # Global styles
│   └── public/
│       ├── terms.html          # Terms of service
│       └── privacy.html        # Privacy policy
│
├── backend/                     # Express backend server
│   ├── src/
│   │   ├── server.ts           # Main server file
│   │   ├── auth/
│   │   │   └── passport-config.ts  # Google OAuth setup
│   │   ├── middleware/
│   │   │   └── auth.ts         # Auth middleware
│   │   ├── routes/
│   │   │   ├── auth.ts         # Auth routes
│   │   │   ├── subjects.ts     # Subject CRUD
│   │   │   ├── calculations.ts # Calculation endpoints
│   │   │   └── export.ts       # Export endpoints
│   │   ├── lib/
│   │   │   └── prisma.ts       # Database client
│   │   └── utils/
│   │       └── calculations.ts # Backend calculations
│   ├── prisma/
│   │   ├── schema.prisma       # Database schema
│   │   └── migrations/         # Database migrations
│   └── api/
│       └── index.ts            # Vercel serverless entry
│
├── tests/
│   └── sgpa.test.ts            # Unit tests for calculations
│
├── docs/                        # Documentation
│   ├── ROADMAP.md
│   ├── UI-REFERENCE.md
│   └── example-payloads.json
│
├── package.json                 # Frontend dependencies
├── vite.config.ts              # Vite configuration
├── tailwind.config.js          # Tailwind CSS config
├── tsconfig.json               # TypeScript config
└── README.md                   # This file
```

---

## 🚀 Quick Start

### Prerequisites
- **Node.js** 18+ and npm/yarn
- **Modern Browser** (Chrome, Firefox, Safari, Edge)
- **PostgreSQL Database** (optional, for backend deployment)

### Local Development

#### Frontend Only (No Backend)

```powershell
# Clone the repository
git clone https://github.com/workwithaaditya/smart-CGPA-calculator.git
cd smart-CGPA-calculator

# Install frontend dependencies
npm install

# Start development server
npm run dev
```

The app will open at `http://localhost:5173` and work completely offline with localStorage.

#### Full Stack (Frontend + Backend)

```powershell
# Install frontend dependencies
npm install

# Install backend dependencies
cd backend
npm install

# Set up environment variables (see Backend Setup below)
# Create backend/.env with your database and Google OAuth credentials

# Run backend server
npm run dev

# In another terminal, run frontend
cd ..
npm run dev
```

### Build for Production

```powershell
# Create optimized production build
npm run build

# Preview production build
npm run preview
```

---

## 📋 How To Use

### 1️⃣ Add Your Subjects
- Click **"+ Add Subject"** button
- Fill in:
  - **Subject Code** (e.g., 22ISE443)
  - **Subject Name** (e.g., Data Structures using C)
  - **CIE Marks** (0-50)
  - **SEE Marks** (0-100, adjustable later)
  - **Credits** (1-20)
- Click **"Add Subject"**

### 2️⃣ Adjust Marks & See Live SGPA
- Use the **slider** on each subject card to adjust SEE marks
- Watch the **Live SGPA** update instantly at the top
- SGPA color changes based on performance:
  - 🟢 Green (9.0-10.0) - Outstanding
  - 🔵 Blue (8.0-8.9) - Excellent
  - 🟣 Purple (7.0-7.9) - Very Good
  - 🟠 Amber (6.0-6.9) - Good
  - 🔴 Red (<6.0) - Needs Improvement

### 3️⃣ Edit or Remove Subjects
- Click **Edit** icon (✏️) to modify subject details
- Click **Delete** icon (🗑️) to remove a subject
- Changes sync automatically if logged in

### 4️⃣ Use the Planner
- Click **"Show Planner"** button
- Set your **Target SGPA**
- View recommended SEE marks for each subject
- See if target is achievable with current CIE marks

### 5️⃣ View Analytics
- Switch to **"Analytics & Planner"** tab
- Explore charts showing:
  - Grade distribution across subjects
  - Performance visualization
  - Subject-wise impact on SGPA

### 6️⃣ Export Your Data
- **Export JSON** - Download complete data in JSON format
- **Export PDF** - Generate a printable PDF report
- Share with advisors, parents, or keep for records

### 7️⃣ Optional: Sign In for Cloud Sync
- Click **"Sign In"** with Google
- Your data syncs automatically to the cloud
- Access from any device by signing in
- **Note**: App works perfectly without login (offline-first)

---

## 🔧 Backend Setup (Optional)

The app works perfectly **without a backend** using localStorage. Set up the backend only if you want:
- Google OAuth login
- Cloud sync across devices
- Multi-user support

### Environment Variables

Create `backend/.env`:

```env
# Database (Neon PostgreSQL)
DATABASE_URL="postgresql://user:password@host/database?sslmode=require"

# Google OAuth Credentials
GOOGLE_CLIENT_ID="your-google-client-id.apps.googleusercontent.com"
GOOGLE_CLIENT_SECRET="your-google-client-secret"

# Session Secret
SESSION_SECRET="your-random-session-secret-here"

# URLs
FRONTEND_URL="http://localhost:5173"
BACKEND_URL="http://localhost:5000"

# Node Environment
NODE_ENV="development"
```

### Google OAuth Setup

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing
3. Enable **Google+ API**
4. Go to **Credentials** → **Create Credentials** → **OAuth 2.0 Client ID**
5. Configure OAuth consent screen
6. Add authorized redirect URIs:
   - Development: `http://localhost:5000/auth/google/callback`
   - Production: `https://your-backend.vercel.app/auth/google/callback`
7. Copy **Client ID** and **Client Secret** to `.env`

### Database Setup (Neon)

1. Sign up at [Neon.tech](https://neon.tech)
2. Create a new project
3. Copy the connection string to `DATABASE_URL` in `.env`
4. Run migrations:

```powershell
cd backend
npx prisma migrate deploy
npx prisma generate
```

### Run Backend

```powershell
cd backend
npm run dev
```

Backend runs on `http://localhost:5000`

---

## 📊 Sample Data

### Input Example

```json
{
  "subjects": [
    {
      "code": "22CS101",
      "name": "Computer Graphics",
      "cie": 45,
      "see": 85,
      "credits": 3
    },
    {
      "code": "22CS102",
      "name": "Algorithm Design",
      "cie": 42,
      "see": 78,
      "credits": 4
    },
    {
      "code": "22CS103",
      "name": "Database Management",
      "cie": 48,
      "see": 92,
      "credits": 4
    }
  ]
}
```

### Calculation Output

```json
{
  "sgpa": 8.82,
  "totalCredits": 11,
  "totalWeighted": 97,
  "maxSgpaIfAll100": 9.18,
  "subjects": [
    {
      "code": "22CS101",
      "name": "Computer Graphics",
      "cie": 45,
      "see": 85,
      "total": 87.5,
      "gp": 9,
      "weighted": 27,
      "grade": "A+"
    },
    {
      "code": "22CS102",
      "name": "Algorithm Design",
      "cie": 42,
      "see": 78,
      "total": 81.0,
      "gp": 9,
      "weighted": 36,
      "grade": "A+"
    },
    {
      "code": "22CS103",
      "name": "Database Management",
      "cie": 48,
      "see": 92,
      "total": 94.0,
      "gp": 10,
      "weighted": 40,
      "grade": "O"
    }
  ]
}
```

---

## 🧪 Testing

### Run Unit Tests

```powershell
# Run all tests
npm test

# Run tests in watch mode
npm run test:watch

# Generate coverage report
npm run test:coverage
```

### Test Coverage

Comprehensive unit tests covering:
- ✅ Total calculation with SEE scaling
- ✅ Grade point boundary conditions
- ✅ SGPA calculation for multiple subjects
- ✅ Edge cases (zero marks, max marks, single subject)
- ✅ Planner logic and target feasibility
- ✅ Export functionality

---

## 🚀 Deployment

### Frontend Deployment (Vercel)

```powershell
# Install Vercel CLI
npm i -g vercel

# Deploy
vercel

# For production
vercel --prod
```

**Environment Variables on Vercel:**
- `VITE_API_URL` - Your backend URL (if using backend)

### Backend Deployment (Vercel Serverless)

```powershell
cd backend
vercel

# Set environment variables
vercel env add DATABASE_URL
vercel env add GOOGLE_CLIENT_ID
vercel env add GOOGLE_CLIENT_SECRET
vercel env add SESSION_SECRET
vercel env add FRONTEND_URL

# Deploy to production
vercel --prod
```

### Alternative: Deploy Frontend Only

If you don't need authentication/sync:

1. Remove backend-related code from frontend
2. Deploy frontend to Vercel/Netlify/GitHub Pages
3. App works perfectly with localStorage

---

## 🎨 Customization

### Grading System

Edit `frontend/src/lib/SGPAEngine.ts`:

```typescript
export const DEFAULT_GRADING_CONFIG: GradingConfig = {
  maxCIE: 50,
  maxSEE: 100,
  roundingDigits: 2,
  buckets: [
    { min: 90, gp: 10, label: 'O' },   // Customize these
    { min: 80, gp: 9, label: 'A+' },
    { min: 70, gp: 8, label: 'A' },
    { min: 60, gp: 7, label: 'B+' },
    { min: 50, gp: 6, label: 'B' },
    { min: 40, gp: 5, label: 'C' },
    { min: 0, gp: 4, label: 'F' }
  ]
};
```

### Theme Colors

Edit `frontend/src/App.tsx` for SGPA color thresholds:

```typescript
const sgpaAccent = result.sgpa >= 9
  ? 'from-green-600/40 to-green-700/40 border-green-500/60'  // Outstanding
  : result.sgpa >= 8
    ? 'from-blue-600/40 to-blue-700/40 border-blue-500/60'   // Excellent
    : // ... customize here
```

### Tailwind Theme

Edit `tailwind.config.js` for global theme changes.

---

## 📈 Performance Optimizations

- **Memoization**: `useMemo` for expensive SGPA calculations
- **Debounced Sync**: 2-second delay for slider changes, 1-second for add/edit
- **Callback Optimization**: `useCallback` prevents unnecessary re-renders
- **Lazy Loading**: Components loaded on-demand
- **Code Splitting**: Vite automatically splits code for faster loads

---

## 🔒 Security Features

- **Input Validation**: All user inputs validated on frontend and backend
- **SQL Injection Prevention**: Prisma ORM with parameterized queries
- **XSS Protection**: React automatically escapes output
- **CSRF Protection**: Express session with secure cookies
- **Secure Sessions**: HTTP-only, SameSite cookies
- **Environment Variables**: Sensitive data never committed to git

---

## 🐛 Troubleshooting

### Common Issues

**Issue**: Frontend can't connect to backend
```powershell
# Solution: Check VITE_API_URL in frontend
# Make sure backend is running on correct port
```

**Issue**: Google OAuth not working
```powershell
# Solution: Verify redirect URIs in Google Console
# Check GOOGLE_CLIENT_ID and GOOGLE_CLIENT_SECRET in .env
```

**Issue**: Database connection failed
```powershell
# Solution: Verify DATABASE_URL is correct
# Run: npx prisma migrate deploy
```

**Issue**: Changes not syncing
```powershell
# Solution: Check browser console for errors
# Verify you're logged in (check top-right corner)
# Check network tab for failed API calls
```

---

## 🤝 Contributing

Contributions are welcome! Here's how:

1. **Fork** the repository
2. **Create** a feature branch
   ```powershell
   git checkout -b feature/amazing-feature
   ```
3. **Commit** your changes
   ```powershell
   git commit -m 'Add amazing feature'
   ```
4. **Push** to your branch
   ```powershell
   git push origin feature/amazing-feature
   ```
5. **Open** a Pull Request

### Contribution Guidelines

- Follow existing code style
- Write tests for new features
- Update documentation as needed
- Keep commits atomic and well-described
- Test thoroughly before submitting PR

---

## 📝 Roadmap

- [ ] Multi-semester CGPA tracking
- [ ] GPA to percentage conversion
- [ ] Import data from CSV/Excel
- [ ] Share results via link
- [ ] Mobile app (React Native)
- [ ] Semester comparison analytics
- [ ] Grade prediction using ML
- [ ] Integration with university portals

See [ROADMAP.md](docs/ROADMAP.md) for detailed plans.

---

## 📄 License

This project is licensed under the **MIT License**.

```
MIT License

Copyright (c) 2025 Aaditya Negi

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## 🙏 Acknowledgments

- **React Team** - For the amazing UI library
- **Vercel** - For seamless deployment platform
- **Neon** - For serverless PostgreSQL
- **Tailwind Labs** - For utility-first CSS framework
- **All Contributors** - For making this project better

### Built With

- [React](https://react.dev/) - UI library
- [TypeScript](https://www.typescriptlang.org/) - Type safety
- [Vite](https://vitejs.dev/) - Build tool
- [Tailwind CSS](https://tailwindcss.com/) - Styling
- [Framer Motion](https://www.framer.com/motion/) - Animations
- [Prisma](https://www.prisma.io/) - Database ORM
- [Passport.js](http://www.passportjs.org/) - Authentication
- [html2canvas](https://html2canvas.hertzen.com/) - PDF generation
- [jsPDF](https://github.com/parallax/jsPDF) - PDF export

---

## 📞 Support & Contact

- **GitHub Issues**: [Report bugs or request features](https://github.com/workwithaaditya/smart-CGPA-calculator/issues)
- **Email**: workwithaaditya@example.com
- **GitHub**: [@workwithaaditya](https://github.com/workwithaaditya)
- **LinkedIn**: [Connect with me](https://www.linkedin.com/in/workwithaaditya/)

---

## ⭐ Show Your Support

If this project helped you, please consider:
- ⭐ **Starring** this repository
- 🍴 **Forking** and contributing
- 📢 **Sharing** with your friends and classmates
- 💬 **Providing feedback** via issues

---

<div align="center">

**Made with ❤️ by [Aaditya](https://github.com/workwithaaditya)**

*Empowering students to track and optimize their academic performance*

[⬆ Back to Top](#-smart-cgpa-calculator)

</div>
