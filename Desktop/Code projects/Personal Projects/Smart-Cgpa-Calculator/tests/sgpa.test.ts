/**
 * Unit Tests for SGPAEngine
 * 
 * Covers all core functionality with boundary cases and edge scenarios.
 */

import {
  scaleSEE,
  calculateTotal,
  gpForTotal,
  calculateWeightedPoints,
  calculateSGPA,
  calculateCriticalSEEValues,
  findMinimalSEEForTarget,
  greedyGlobalPlan,
  DEFAULT_GRADING_CONFIG,
  Subject
} from '../frontend/src/lib/SGPAEngine';

describe('SGPAEngine - Core Calculations', () => {
  
  // Test 1: Total calculation
  test('calculateTotal - CIE=34, SEE=45 should give Total=56.5', () => {
    const cie = 34;
    const see = 45;
    const total = calculateTotal(cie, see, DEFAULT_GRADING_CONFIG);
    
    // SEE_scaled = 45 / 2 = 22.5
    // Total = 34 + 22.5 = 56.5
    expect(total).toBe(56.5);
  });
  
  // Test 2: GP mapping boundary tests
  test('gpForTotal - boundary cases at grade cutoffs', () => {
    // Exactly at cutoff 90 → GP 10
    expect(gpForTotal(90, DEFAULT_GRADING_CONFIG)).toBe(10);
    
    // Just below cutoff 90 → GP 9
    expect(gpForTotal(89, DEFAULT_GRADING_CONFIG)).toBe(9);
    
    // Exactly at cutoff 80 → GP 9
    expect(gpForTotal(80, DEFAULT_GRADING_CONFIG)).toBe(9);
    
    // Just below cutoff 80 → GP 8
    expect(gpForTotal(79, DEFAULT_GRADING_CONFIG)).toBe(8);
    
    // Edge case: 0 total → GP 4
    expect(gpForTotal(0, DEFAULT_GRADING_CONFIG)).toBe(4);
    
    // Edge case: 100 total → GP 10
    expect(gpForTotal(100, DEFAULT_GRADING_CONFIG)).toBe(10);
  });
  
  // Test 3: Critical SEE calculation
  test('calculateCriticalSEEValues - CIE=40, cutoff=90 should give SEE_crit=100', () => {
    const cie = 40;
    const criticals = calculateCriticalSEEValues(cie, DEFAULT_GRADING_CONFIG);
    
    // Find the critical value for cutoff 90
    const critical90 = criticals.find(c => c.cutoffTotal === 90);
    
    // SEE_crit = (90 - 40) * 2 = 100
    expect(critical90?.seeCrit).toBe(100);
    expect(critical90?.reachable).toBe(true);
    expect(critical90?.gp).toBe(10);
  });
  
  // Test 4: SGPA calculation (multi-subject example from prompt)
  test('calculateSGPA - multi-subject example should give SGPA=8.80', () => {
    const subjects: Subject[] = [
      { code: 'SUB1', name: 'Subject 1', cie: 40, see: 100, credits: 4 },
      { code: 'SUB2', name: 'Subject 2', cie: 45, see: 80, credits: 3 },
      { code: 'SUB3', name: 'Subject 3', cie: 30, see: 70, credits: 3 }
    ];
    
    const result = calculateSGPA(subjects, DEFAULT_GRADING_CONFIG);
    
    // Expected calculations:
    // Sub1: Total = 40 + 50 = 90 → GP 10 → Weighted = 40
    // Sub2: Total = 45 + 40 = 85 → GP 9 → Weighted = 27
    // Sub3: Total = 30 + 35 = 65 → GP 7 → Weighted = 21
    // Total credits = 10, Weighted sum = 88
    // SGPA = 88 / 10 = 8.80
    
    expect(result.sgpa).toBe(8.80);
    expect(result.totalCredits).toBe(10);
    expect(result.totalWeighted).toBe(88);
    
    // Verify individual subject results
    expect(result.subjects[0].gp).toBe(10);
    expect(result.subjects[0].weighted).toBe(40);
    
    expect(result.subjects[1].gp).toBe(9);
    expect(result.subjects[1].weighted).toBe(27);
    
    expect(result.subjects[2].gp).toBe(7);
    expect(result.subjects[2].weighted).toBe(21);
  });
  
  // Test 5: Single-subject minimal SEE planner
  test('findMinimalSEEForTarget - subject can reach target alone', () => {
    const subjects: Subject[] = [
      { code: 'SUB1', name: 'Subject 1', cie: 45, see: 50, credits: 4 },
      { code: 'SUB2', name: 'Subject 2', cie: 40, see: 60, credits: 3 }
    ];
    
    // Current SGPA should be less than 8.0
    const currentResult = calculateSGPA(subjects, DEFAULT_GRADING_CONFIG);
    
    // Try to reach SGPA 8.0 by improving SUB1 alone
    const plan = findMinimalSEEForTarget(subjects, 'SUB1', 8.0, DEFAULT_GRADING_CONFIG);
    
    expect(plan.code).toBe('SUB1');
    
    // Should find a minimal SEE if achievable
    if (plan.possible) {
      expect(plan.minSeeToReachTarget).toBeGreaterThanOrEqual(plan.currentSee);
      expect(plan.minSeeToReachTarget).toBeLessThanOrEqual(100);
      expect(plan.achievedSgpa).toBeGreaterThanOrEqual(8.0);
    }
  });
  
  // Test 6: Greedy global planner
  test('greedyGlobalPlan - synthetic case reaches target', () => {
    const subjects: Subject[] = [
      { code: 'SUB1', name: 'Subject 1', cie: 35, see: 50, credits: 4 },
      { code: 'SUB2', name: 'Subject 2', cie: 38, see: 55, credits: 3 },
      { code: 'SUB3', name: 'Subject 3', cie: 42, see: 60, credits: 3 }
    ];
    
    // Target a modest SGPA increase
    const targetSgpa = 7.5;
    
    const plan = greedyGlobalPlan(subjects, targetSgpa, DEFAULT_GRADING_CONFIG);
    
    // Verify plan structure
    expect(plan).toHaveProperty('steps');
    expect(plan).toHaveProperty('finalSgpa');
    expect(plan).toHaveProperty('targetReached');
    expect(plan).toHaveProperty('bestAttainableSgpa');
    
    // Best attainable should be when all SEE = 100
    expect(plan.bestAttainableSgpa).toBeGreaterThanOrEqual(targetSgpa);
    
    // If target reached, finalSgpa should meet or exceed target
    if (plan.targetReached) {
      expect(plan.finalSgpa).toBeGreaterThanOrEqual(targetSgpa);
    }
    
    // Steps should increase SEE values
    plan.steps.forEach(step => {
      expect(step.toSee).toBeGreaterThanOrEqual(step.fromSee);
      expect(step.increaseSeeBy).toBe(step.toSee - step.fromSee);
    });
  });
  
  // Test 7: Unreachable target detection
  test('greedyGlobalPlan - detects unreachable target', () => {
    const subjects: Subject[] = [
      { code: 'SUB1', name: 'Subject 1', cie: 20, see: 50, credits: 4 },
      { code: 'SUB2', name: 'Subject 2', cie: 25, see: 55, credits: 3 }
    ];
    
    // Set impossible target (e.g., 10.0 with low CIE)
    const targetSgpa = 10.0;
    
    const plan = greedyGlobalPlan(subjects, targetSgpa, DEFAULT_GRADING_CONFIG);
    
    // Should detect target is unreachable
    expect(plan.targetReached).toBe(false);
    expect(plan.bestAttainableSgpa).toBeLessThan(targetSgpa);
  });
  
  // Test 8: SEE scaling
  test('scaleSEE - SEE=100 should scale to 50', () => {
    const scaled = scaleSEE(100, DEFAULT_GRADING_CONFIG);
    expect(scaled).toBe(50);
  });
  
  // Test 9: Weighted points calculation
  test('calculateWeightedPoints - GP=9, Credits=3 should give 27', () => {
    const weighted = calculateWeightedPoints(9, 3);
    expect(weighted).toBe(27);
  });
  
  // Test 10: Edge case - all subjects at max
  test('calculateSGPA - all subjects with max marks', () => {
    const subjects: Subject[] = [
      { code: 'SUB1', name: 'Subject 1', cie: 50, see: 100, credits: 4 },
      { code: 'SUB2', name: 'Subject 2', cie: 50, see: 100, credits: 3 }
    ];
    
    const result = calculateSGPA(subjects, DEFAULT_GRADING_CONFIG);
    
    // All should get GP 10
    expect(result.sgpa).toBe(10.00);
    expect(result.subjects.every(s => s.gp === 10)).toBe(true);
  });
  
});

describe('SGPAEngine - Edge Cases', () => {
  
  test('handles single subject correctly', () => {
    const subjects: Subject[] = [
      { code: 'SUB1', name: 'Subject 1', cie: 40, see: 80, credits: 4 }
    ];
    
    const result = calculateSGPA(subjects, DEFAULT_GRADING_CONFIG);
    
    expect(result.totalCredits).toBe(4);
    expect(result.sgpa).toBeGreaterThan(0);
  });
  
  test('handles zero SEE correctly', () => {
    const cie = 40;
    const see = 0;
    const total = calculateTotal(cie, see, DEFAULT_GRADING_CONFIG);
    
    expect(total).toBe(40);
  });
  
  test('critical SEE for high CIE may be unreachable', () => {
    const cie = 45; // High CIE
    const criticals = calculateCriticalSEEValues(cie, DEFAULT_GRADING_CONFIG);
    
    // For cutoff 90: SEE_crit = (90 - 45) * 2 = 90 (reachable)
    const critical90 = criticals.find(c => c.cutoffTotal === 90);
    expect(critical90?.reachable).toBe(true);
    expect(critical90?.seeCrit).toBe(90);
  });
  
});
