# Example Payloads for Smart CGPA Calculator

## Example 1: Multi-Subject Scenario (From Prompt)

### Input
```json
{
  "subjects": [
    {
      "code": "CS101",
      "name": "Computer Graphics",
      "cie": 40,
      "see": 100,
      "credits": 4
    },
    {
      "code": "ALG01",
      "name": "Algorithm Design",
      "cie": 45,
      "see": 80,
      "credits": 3
    },
    {
      "code": "DB101",
      "name": "Database Systems",
      "cie": 30,
      "see": 70,
      "credits": 3
    }
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
      "cie": 40,
      "see": 100,
      "seeScaled": 50.0,
      "total": 90.0,
      "gp": 10,
      "weighted": 40.0,
      "credits": 4
    },
    {
      "code": "ALG01",
      "name": "Algorithm Design",
      "cie": 45,
      "see": 80,
      "seeScaled": 40.0,
      "total": 85.0,
      "gp": 9,
      "weighted": 27.0,
      "credits": 3
    },
    {
      "code": "DB101",
      "name": "Database Systems",
      "cie": 30,
      "see": 70,
      "seeScaled": 35.0,
      "total": 65.0,
      "gp": 7,
      "weighted": 21.0,
      "credits": 3
    }
  ],
  "sgpa": 8.80,
  "totalCredits": 10,
  "totalWeighted": 88.0,
  "maxSgpaIfAll100": 9.10
}
```

### Manual Verification
```
Subject 1: CIE=40, SEE=100
  SEE_scaled = 100/2 = 50
  Total = 40 + 50 = 90
  GP = 10 (90-100 range)
  Weighted = 10 × 4 = 40

Subject 2: CIE=45, SEE=80
  SEE_scaled = 80/2 = 40
  Total = 45 + 40 = 85
  GP = 9 (80-89 range)
  Weighted = 9 × 3 = 27

Subject 3: CIE=30, SEE=70
  SEE_scaled = 70/2 = 35
  Total = 30 + 35 = 65
  GP = 7 (60-69 range)
  Weighted = 7 × 3 = 21

Total Credits = 4 + 3 + 3 = 10
Total Weighted = 40 + 27 + 21 = 88
SGPA = 88 / 10 = 8.80 ✓
```

See full documentation in docs/example-payloads.md
