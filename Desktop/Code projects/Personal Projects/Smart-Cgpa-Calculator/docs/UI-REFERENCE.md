# UI/UX Design Reference

## Design Philosophy

The Smart CGPA Calculator follows a **clean, card-based design** with emphasis on:
- **Clarity**: Information hierarchy that guides the eye
- **Interactivity**: Responsive feedback for every action
- **Accessibility**: WCAG 2.1 AA compliance
- **Performance**: Smooth 60fps animations

---

## Color Palette

### Primary Colors
```css
Blue Primary:    #3b82f6  /* Buttons, highlights */
Blue Dark:       #1e40af  /* Headings */
Purple Accent:   #8b5cf6  /* Secondary actions */
```

### Grade Colors (Colorblind-Safe)
```css
Grade O (10):    #10b981  /* Green - Excellent */
Grade A+ (9):    #3b82f6  /* Blue - Very Good */
Grade A (8):     #8b5cf6  /* Purple - Good */
Grade B+ (7):    #f59e0b  /* Amber - Satisfactory */
Grade C (5-6):   #ef4444  /* Red - Pass */
Grade F (4):     #991b1b  /* Dark Red - Fail */
```

### Neutral Colors
```css
Background:      #f9fafb  /* Light gray */
Card Background: #ffffff  /* White */
Text Primary:    #111827  /* Near black */
Text Secondary:  #6b7280  /* Gray */
Border:          #e5e7eb  /* Light gray */
```

---

## Typography

### Font Stack
```css
font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 
             'Roboto', 'Oxygen', 'Ubuntu', 'Cantarell', 
             'Fira Sans', 'Droid Sans', 'Helvetica Neue', 
             sans-serif;
```

### Scale
```css
Heading 1:   36px / 2.25rem  (Page title)
Heading 2:   30px / 1.875rem (Section headers)
Heading 3:   24px / 1.5rem   (Card titles)
Body:        16px / 1rem     (Default text)
Small:       14px / 0.875rem (Labels)
Tiny:        12px / 0.75rem  (Captions)
```

### Weights
```css
Regular:     400  (Body text)
Medium:      500  (Labels)
Semibold:    600  (Important info)
Bold:        700  (Headings, numbers)
```

---

## Component Specifications

### 1. Subject Card

**Dimensions**: 
- Desktop: 400-500px width, auto height
- Mobile: 100% width, stacked

**Structure**:
```
┌─────────────────────────────────────┐
│ Subject Name              [3 Credits]│  ← Header with badge
│ CS101                                │  ← Code
├─────────────────────────────────────┤
│ Internal (CIE): 40 / 50              │  ← Fixed CIE display
├─────────────────────────────────────┤
│ Semester End Exam (SEE)              │  ← Label
│ [■■■■■■■░░░░░░░░░░░░░] 65           │  ← Slider with markers
│ 0                GP 8 (A)        100 │  ← Scale + current grade
├─────────────────────────────────────┤
│ ┌─────────┬─────────┐               │
│ │SEE:50.0 │Total:85 │  ← Stats grid │
│ ├─────────┼─────────┤               │
│ │  GP: 9  │Wgtd: 27 │               │
│ └─────────┴─────────┘               │
├─────────────────────────────────────┤
│ Max SGPA (if SEE=100): 9.20          │  ← Max badge
└─────────────────────────────────────┘
```

**Styling**:
- Border radius: 12px
- Shadow: 0 4px 6px rgba(0,0,0,0.1)
- Padding: 24px
- Border: 2px solid (gray default, blue when selected)

---

### 2. Interactive Slider

**Specifications**:
```
Height: 48px
Width: 100%
Border radius: 8px
Track: Gradient showing grade bands
Handle: 24px circle, white with blue border
Markers: 1px white vertical lines at critical SEE values
```

**Behavior**:
- Draggable with mouse/touch
- Keyboard: Arrow keys (±1), Shift+Arrow (±5), Home/End
- Hover over marker shows tooltip
- Crossing grade boundary triggers toast animation

**Gradient Example** (CIE = 40):
```
SEE 0-20:   Red (#ef4444)     - GP 4-5
SEE 20-40:  Amber (#f59e0b)   - GP 6
SEE 40-60:  Purple (#8b5cf6)  - GP 7
SEE 60-80:  Blue (#3b82f6)    - GP 8
SEE 80-100: Green (#10b981)   - GP 9-10
```

---

### 3. Dashboard Stats Bar

**Layout**: 4-column grid (responsive to 2-col on tablet, 1-col on mobile)

```
┌─────────────┬─────────────┬─────────────┬─────────────┐
│ SGPA        │ Credits     │ Weighted    │ Max SGPA    │
│   8.80      │    10       │   88.0      │   9.10      │
└─────────────┴─────────────┴─────────────┴─────────────┘
```

**Each Card**:
- Height: 120px
- Background: White with colored left border (4px)
- Value: 36px bold, colored
- Label: 14px gray, above value

---

### 4. Charts

**Line Chart** (SEE → SGPA):
- Width: 100%
- Height: 300px
- X-axis: SEE marks (0-100)
- Y-axis: SGPA (auto-scaled)
- Line: Step function (stepAfter interpolation), blue, 2px
- Grid: Light gray dotted
- Tooltip: Show SEE, SGPA, GP on hover

**Bar Chart** (Marginal Gains):
- Width: 100%
- Height: 300px
- Bars: Colored by gain magnitude (green > blue > amber > gray)
- X-axis: Subject codes
- Y-axis: SGPA gain per +1 SEE
- Sorted: Descending by gain (Pareto principle)

---

### 5. Planner Component

**Tabs**: Per-Subject | Global Strategy

**Per-Subject Cards**:
```
┌─────────────────────────────────────┐
│ Computer Graphics (CS101)  [Possible]│  ← Green badge
├─────────────────────────────────────┤
│ Current SEE:  45                     │
│ Need SEE:     92    (+47 marks)      │
│ Achieves:     8.52 SGPA              │
└─────────────────────────────────────┘
```

**Global Plan Steps**:
```
1. ▸ Algorithm Design (ALG01)
   SEE: 60 → 80 (+20) → SGPA: 7.50

2. ▸ Computer Graphics (CS101)
   SEE: 45 → 70 (+25) → SGPA: 8.20

3. ▸ Algorithm Design (ALG01)
   SEE: 80 → 90 (+10) → SGPA: 8.55 ✓
```

---

## Responsive Breakpoints

```css
Mobile:     < 640px   (1 column, stacked)
Tablet:     640-1024px (2 columns)
Desktop:    > 1024px   (2 columns, side-by-side)
```

---

## Animations & Transitions

### Slider Drag
```css
transition: none during drag
requestAnimationFrame for smooth updates
```

### Grade Boundary Cross
```css
Toast: fadeIn 200ms, hold 1800ms, fadeOut 200ms
Handle pulse: scale(1.1) over 300ms ease-out
```

### Button Hover
```css
transform: translateY(-2px)
box-shadow: increase intensity
duration: 150ms ease
```

### Card Selection
```css
border-color: blue
ring: 2px blue, offset 2px
duration: 200ms
```

---

## Accessibility Features

### ARIA Labels
```html
<div role="slider" 
     aria-label="SEE marks for Computer Graphics"
     aria-valuemin="0" 
     aria-valuemax="100" 
     aria-valuenow="65"
     aria-valuetext="65 out of 100">
```

### Keyboard Navigation
- Tab: Move between interactive elements
- Arrow keys: Adjust slider values
- Enter/Space: Activate buttons
- Escape: Close modals/dialogs

### High Contrast Mode
Toggle switches to:
- Background: Black (#000000)
- Text: White (#ffffff)
- Borders: 2px solid white
- Enhanced focus indicators

---

## Performance Guidelines

### Target Metrics
- First Contentful Paint: < 1.5s
- Time to Interactive: < 3s
- Frame rate during slider drag: 60fps
- SGPA recalculation: < 16ms

### Optimization Techniques
- React.memo for expensive components
- useCallback for event handlers
- Debounce heavy calculations (chart updates)
- Throttle slider updates (100ms)
- Code splitting for planner/charts

---

## Implementation Notes

### Slider Gradient Generation
```typescript
const generateGradient = () => {
  const criticals = calculateCriticalSEEValues(cie);
  const stops = [];
  
  for (let i = 0; i < criticals.length - 1; i++) {
    const start = (criticals[i].seeCrit / 100) * 100;
    const end = (criticals[i + 1].seeCrit / 100) * 100;
    const color = gradeColors[criticals[i].gp];
    
    stops.push(`${color} ${start}%`, `${color} ${end}%`);
  }
  
  return `linear-gradient(to right, ${stops.join(', ')})`;
};
```

### Toast Animation
```typescript
const showToast = (oldGP: number, newGP: number) => {
  const direction = newGP > oldGP ? '↑' : '↓';
  setToast({
    text: `Grade ${direction}: GP ${oldGP} → ${newGP}`,
    visible: true
  });
  
  setTimeout(() => setToast(prev => ({...prev, visible: false})), 2000);
};
```

---

## Reference Screenshot Analysis

Based on the provided reference images, the design emphasizes:

1. **Clean Card Layout**: White cards with subtle shadows, clear hierarchy
2. **Numerical Prominence**: Large, bold numbers for key metrics
3. **Color Coding**: Consistent use of colors to indicate status/importance
4. **Organized Grid**: Structured layout with aligned elements
5. **Minimal Decoration**: Focus on content over ornamentation

These principles have been incorporated into the component specifications above.

---

**This design reference ensures consistency across all components while maintaining accessibility and performance standards.**
