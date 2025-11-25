# Quick Start Guide

## Installation & Running

### 1. Install Dependencies

```powershell
cd "c:\Users\rsneg\Desktop\Code projects\Personal Projects\Smart-Cgpa-Calculator"
npm install
```

This will install:
- React 18.3 + TypeScript
- Vite (build tool)
- Tailwind CSS (styling)
- Recharts (visualizations)
- Jest (testing)
- html2canvas + jsPDF (exports)

### 2. Run Development Server

```powershell
npm run dev
```

The app will open at `http://localhost:3000`

### 3. Run Tests

```powershell
# Run all tests
npm test

# Run tests in watch mode
npm run test:watch

# Generate coverage report
npm run test:coverage
```

### 4. Build for Production

```powershell
npm run build
```

Production build will be in `dist/` folder.

### 5. Preview Production Build

```powershell
npm run preview
```

---

## Project Structure

```
Smart-Cgpa-Calculator/
├── frontend/src/
│   ├── App.tsx                    # Main app component
│   ├── index.tsx                  # Entry point
│   ├── components/
│   │   ├── SubjectCard.tsx        # Subject display
│   │   ├── SubjectSlider.tsx      # Interactive slider
│   │   ├── Charts.tsx             # Visualizations
│   │   └── Planner.tsx            # Intelligent planner
│   ├── lib/
│   │   └── SGPAEngine.ts          # Core calculations
│   └── styles/
│       └── index.css              # Global styles
├── tests/
│   └── sgpa.test.ts               # Unit tests
├── docs/
│   ├── ROADMAP.md                 # Implementation guide
│   ├── UI-REFERENCE.md            # Design specs
│   └── example-payloads.md        # Sample data
├── package.json
├── vite.config.ts
├── tsconfig.json
├── jest.config.js
├── tailwind.config.js
└── README.md
```

---

## Usage Example

1. **Open the app** in your browser
2. **Enter your subjects** (3 pre-loaded by default)
3. **Adjust SEE sliders** to see real-time SGPA updates
4. **Watch for grade changes** - toast notifications appear when crossing boundaries
5. **Click a subject card** to view its SEE → SGPA curve
6. **Open the Planner** to get recommendations for reaching target SGPA
7. **Export results** as JSON or PDF

---

## Testing the Implementation

### Verify Core Calculations

Open browser console and run:

```javascript
// Test multi-subject example from prompt
const subjects = [
  { code: 'SUB1', name: 'Subject 1', cie: 40, see: 100, credits: 4 },
  { code: 'SUB2', name: 'Subject 2', cie: 45, see: 80, credits: 3 },
  { code: 'SUB3', name: 'Subject 3', cie: 30, see: 70, credits: 3 }
];

// Expected SGPA: 8.80
```

### Verify Slider Interactions

1. Move slider for any subject
2. Watch SGPA update in real-time (top left card)
3. Cross a critical marker (e.g., SEE 79 → 80 with CIE 40)
4. Toast should appear: "Grade ↑: GP 8 → GP 9"

### Verify Planner

1. Click "Show Planner"
2. Enter target SGPA: 9.0
3. View per-subject minimal SEE recommendations
4. Switch to "Global Strategy" tab
5. See step-by-step improvement plan

---

## Troubleshooting

### Issue: `npm install` fails
**Solution**: Ensure Node.js 18+ is installed
```powershell
node --version
```

### Issue: Tests fail
**Solution**: Check TypeScript compilation
```powershell
npx tsc --noEmit
```

### Issue: Styles not loading
**Solution**: Restart dev server
```powershell
# Press Ctrl+C to stop, then:
npm run dev
```

### Issue: Charts not rendering
**Solution**: Check browser console for errors. Recharts requires modern browser.

---

## Next Steps

1. ✅ Run `npm install`
2. ✅ Run `npm run dev`
3. ✅ Open browser to `http://localhost:3000`
4. ✅ Test all features
5. ✅ Run `npm test` to verify calculations
6. ✅ Read `docs/ROADMAP.md` for customization guide

---

## Deployment Options

### Option 1: Vercel (Recommended)
```powershell
# Install Vercel CLI
npm install -g vercel

# Deploy
vercel
```

### Option 2: Netlify
```powershell
# Build first
npm run build

# Drag `dist/` folder to Netlify web interface
```

### Option 3: GitHub Pages
```powershell
# Add to package.json:
"homepage": "https://yourusername.github.io/smart-cgpa-calculator",

# Install gh-pages
npm install -D gh-pages

# Add deploy script to package.json:
"deploy": "npm run build && gh-pages -d dist"

# Deploy
npm run deploy
```

---

**You're all set! Happy calculating! 🎓**
