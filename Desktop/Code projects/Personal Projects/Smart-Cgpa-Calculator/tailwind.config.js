/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./frontend/src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        'grade-o': '#10b981',
        'grade-a': '#3b82f6',
        'grade-b': '#8b5cf6',
        'grade-c': '#f59e0b',
        'grade-d': '#ef4444',
        'grade-f': '#991b1b',
      }
    },
  },
  plugins: [],
}
