# 🎓 Smart CGPA Calculator

> **Production-ready full-stack web application for calculating, tracking, and optimizing academic CGPA with Google OAuth authentication and data persistence.**

![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)
![React](https://img.shields.io/badge/React-18.3-61dafb.svg)
![TypeScript](https://img.shields.io/badge/TypeScript-5.3-3178c6.svg)
![Express](https://img.shields.io/badge/Express-4.18-000000.svg)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-14+-336791.svg)

---

## ✨ Features

### 🔐 **NEW: Full Authentication & Data Persistence**
- **Google OAuth 2.0** - Secure login with Google accounts
- **Session Management** - Persistent sessions stored in PostgreSQL
- **Per-User Data** - Complete data isolation for each user
- **Cloud Sync** - Access your data from any device

### 📊 **Grade Calculation**

### Core Functionality
- **Real-time SGPA Calculation**: Instantly calculates SGPA as you adjust semester-end exam (SEE) marks
- **Interactive Sliders**: Beautiful, segmented sliders with visual grade boundaries and critical markers
- **Per-Subject Analysis**: View total marks, grade points, and weighted contributions for each subject
- **Critical SEE Markers**: Visual indicators showing exactly how many marks needed to reach next grade level

### Advanced Analytics
- **Line Charts**: Visualize how SEE marks affect SGPA for any subject
- **Marginal Gain Analysis**: Pareto bar charts showing which subjects offer highest SGPA improvement per mark
- **Intelligent Planner**: 
  - Per-subject minimal SEE recommendations to reach target SGPA
  - Greedy global strategy suggesting optimal improvement sequence
  - Impossibility detection with best attainable SGPA calculation

### User Experience
- **Accessibility**: Full ARIA labels, keyboard navigation, and high-contrast mode
- **Export Options**: Download reports as JSON or PDF
- **Responsive Design**: Works seamlessly on desktop, tablet, and mobile
- **Smooth Animations**: Buttery-smooth slider interactions with grade change notifications

## 📐 How It Works

### Calculation Formulas

```
1. Scale SEE marks:
   SEE_scaled = SEE / 2

2. Calculate subject total:
   Total = CIE + SEE_scaled  (range: 0-100)

3. Map to Grade Point:
   90-100 → GP 10 (O)
   80-89  → GP 9  (A+)
   70-79  → GP 8  (A)
   60-69  → GP 7  (B+)
   50-59  → GP 6  (B)
   40-49  → GP 5  (C)
   0-39   → GP 4  (F)

4. Calculate weighted points:
   WeightedPoints = GP × Credits

5. Calculate SGPA:
   SGPA = (Σ WeightedPoints) / (Σ Credits)
```

### Critical SEE Formula

To reach a specific grade cutoff:
```
SEE_critical = (cutoffTotal - CIE) × 2
```

## 🚀 Quick Start

### Prerequisites
- Node.js 18+ and npm/yarn
- Modern browser (Chrome, Firefox, Safari, Edge)

### Installation

```powershell
# Clone the repository
git clone https://github.com/yourusername/smart-cgpa-calculator.git
cd smart-cgpa-calculator

# Install dependencies
npm install

# Start development server
npm run dev
```

The app will open at `http://localhost:3000`

### Build for Production

```powershell
# Create optimized production build
npm run build

# Preview production build
npm run preview
```

## 📊 Example Usage

### Sample Input (JSON)

```json
{
  "subjects": [
    {
      "code": "CS101",
      "name": "Computer Graphics",
      "cie": 34,
      "see": 45,
      "credits": 3
    },
    {
      "code": "ALG01",
      "name": "Algorithm Design",
      "cie": 40,
      "see": 80,
      "credits": 4
    },
    {
      "code": "DB101",
      "name": "Database Systems",
      "cie": 38,
      "see": 70,
      "credits": 3
    }
  ],
  "grading": [
    {"min": 90, "gp": 10, "label": "O"},
    {"min": 80, "gp": 9, "label": "A+"},
    {"min": 70, "gp": 8, "label": "A"},
    {"min": 60, "gp": 7, "label": "B+"},
    {"min": 50, "gp": 6, "label": "B"},
    {"min": 40, "gp": 5, "label": "C"},
    {"min": 0, "gp": 4, "label": "F"}
  ]
}
```

### Expected Output

```json
{
  "subjects": [
    {
      "code": "CS101",
      "name": "Computer Graphics",
      "total": 56.5,
      "gp": 6,
      "weighted": 18,
      "credits": 3
    },
    {
      "code": "ALG01",
      "name": "Algorithm Design",
      "total": 80.0,
      "gp": 9,
      "weighted": 36,
      "credits": 4
    },
    {
      "code": "DB101",
      "name": "Database Systems",
      "total": 73.0,
      "gp": 8,
      "weighted": 24,
      "credits": 3
    }
  ],
  "sgpa": 7.80,
  "totalCredits": 10,
  "totalWeighted": 78,
  "maxSgpaIfAll100": 9.20
}
```

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

The project includes 10+ comprehensive unit tests covering:
- ✅ Total calculation with SEE scaling
- ✅ Grade point boundary conditions
- ✅ Critical SEE computation
- ✅ Multi-subject SGPA calculation
- ✅ Single-subject planner logic
- ✅ Greedy global planner algorithm
- ✅ Unreachable target detection
- ✅ Edge cases (zero SEE, max marks, single subject)

## 📁 Project Structure

```
smart-cgpa-calculator/
├── README.md
├── package.json
├── tsconfig.json
├── vite.config.ts
├── jest.config.js
├── tailwind.config.js
├── postcss.config.js
├── index.html
├── frontend/
│   ├── src/
│   │   ├── App.tsx                 # Main application component
│   │   ├── index.tsx               # Entry point
│   │   ├── components/
│   │   │   ├── SubjectCard.tsx     # Subject display card
│   │   │   ├── SubjectSlider.tsx   # Interactive SEE slider
│   │   │   ├── Charts.tsx          # Visualization components
│   │   │   └── Planner.tsx         # Intelligent planner UI
│   │   ├── lib/
│   │   │   └── SGPAEngine.ts       # Core calculation engine
│   │   └── styles/
│   │       └── index.css           # Global styles
├── tests/
│   └── sgpa.test.ts                # Comprehensive unit tests
└── docs/
    ├── API.md                      # API documentation
    ├── FORMULAS.md                 # Mathematical formulas
    └── mockups/
        └── example-payloads.json   # Sample data
```

## 🎨 UI Features

### Interactive Slider
- **Segmented Track**: Color-coded for grade ranges
- **Critical Markers**: Vertical lines at grade boundaries
- **Tooltips**: Hover to see exact SEE → GP mapping
- **Smooth Dragging**: 60fps animations with requestAnimationFrame
- **Keyboard Support**: Arrow keys (±1), Shift+Arrow (±5), Home, End

### Accessibility
- Full ARIA labels and roles
- Keyboard navigation support
- High contrast mode toggle
- Screen reader friendly
- Colorblind-safe palette option

### Responsive Design
- Mobile-first approach
- Flexbox/Grid layout
- Touch-optimized sliders
- Collapsible sections on mobile

## 🔧 Configuration

All calculation parameters are configurable via JSON:

```typescript
{
  maxCIE: 50,           // Maximum internal marks
  maxSEE: 100,          // Maximum semester-end marks
  roundingDigits: 2,    // SGPA decimal places
  buckets: [            // Grade cutoffs
    { min: 90, gp: 10, label: 'O' },
    // ... more buckets
  ]
}
```

## 📈 Performance

- **Real-time Updates**: <16ms (60fps) for slider interactions
- **Debounced Calculations**: Heavy computations throttled at 100ms
- **Optimized Rendering**: React.memo and useCallback for expensive components
- **Canvas Charts**: Hardware-accelerated for smooth visualizations

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Built with [React](https://react.dev/) and [TypeScript](https://www.typescriptlang.org/)
- Styled with [Tailwind CSS](https://tailwindcss.com/)
- Charts powered by [Recharts](https://recharts.org/)
- PDF export via [jsPDF](https://github.com/parallax/jsPDF) and [html2canvas](https://html2canvas.hertzen.com/)

## 📞 Support

For issues, questions, or suggestions:
- Open an issue on GitHub
- Email: your.email@example.com
- Documentation: [Wiki](https://github.com/yourusername/smart-cgpa-calculator/wiki)

---

**Made with ❤️ for students everywhere**
