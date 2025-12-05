# k6 Stress Test Analysis

**Test Date:** December 4, 2025  
**Test Duration:** 35 minutes  
**Tool:** k6 v1.4.2  
**Status:** 🔄 IN PROGRESS

---

## 1. Test Configuration

### Virtual Users Profile - Progressive Load Increase

| Stage | Duration | Target VUs | Load Level | Purpose |
|-------|----------|------------|------------|---------|
| Ramp Up 1 | 2 minutes | 50 users | Normal | Baseline establishment |
| Steady 1 | 5 minutes | 50 users | Normal | Baseline observation |
| Ramp Up 2 | 2 minutes | 100 users | 2x Normal | Moderate stress |
| Steady 2 | 5 minutes | 100 users | 2x Normal | Sustained high load |
| Ramp Up 3 | 2 minutes | 200 users | 4x Normal | Heavy stress |
| Steady 3 | 5 minutes | 200 users | 4x Normal | Breaking point approach |
| Ramp Up 4 | 2 minutes | 300 users | 6x Normal | Beyond capacity |
| Steady 4 | 5 minutes | 300 users | 6x Normal | Maximum stress |
| Ramp Down | 5 minutes | 0 users | Recovery | System recovery |

**Total Duration:** 35 minutes  
**Maximum VUs:** 300 concurrent users  
**Load Increase:** From 50 to 300 (6x increase)

### Relaxed Thresholds
```javascript
{
  http_req_duration: ['p(95)<2000'],  // 2 seconds (more relaxed)
  http_req_failed: ['rate<0.1']       // 10% errors allowed
}
```

---

## 2. Test Execution Timeline

### 📸 SCREENSHOT CHECKPOINTS

**Minute 0-7 (50 VUs - Baseline):**
- [ ] Screenshot at 2 minutes (steady state)
- [ ] Note CPU/Memory usage
- [ ] Record response times

**Minute 7-14 (100 VUs - 2x Load):**
- [ ] Screenshot at 9 minutes (steady state)
- [ ] Compare to 50 VU baseline
- [ ] Watch for degradation

**Minute 14-21 (200 VUs - 4x Load):**
- [ ] Screenshot at 16 minutes (steady state)
- [ ] Errors may start appearing
- [ ] Check server resources

**Minute 21-28 (300 VUs - Maximum):**
- [ ] Screenshot at 23 minutes (peak load)
- [ ] Capture error rates
- [ ] System may struggle here

**Minute 28-35 (Recovery):**
- [ ] Screenshot at 30 minutes (recovery)
- [ ] Final summary screenshot
- [ ] Resource cleanup observation

---

## 3. Performance Metrics

### Response Time Progression

| VU Level | Average | p95 | p99 | Max | Status |
|----------|---------|-----|-----|-----|--------|
| 50 VUs | [Fill] ms | [Fill] ms | [Fill] ms | [Fill] ms | [Status] |
| 100 VUs | [Fill] ms | [Fill] ms | [Fill] ms | [Fill] ms | [Status] |
| 200 VUs | [Fill] ms | [Fill] ms | [Fill] ms | [Fill] ms | [Status] |
| 300 VUs | [Fill] ms | [Fill] ms | [Fill] ms | [Fill] ms | [Status] |

### Throughput Analysis

| VU Level | Requests/sec | Total Requests | Iterations |
|----------|--------------|----------------|------------|
| 50 VUs | [Fill] | [Fill] | [Fill] |
| 100 VUs | [Fill] | [Fill] | [Fill] |
| 200 VUs | [Fill] | [Fill] | [Fill] |
| 300 VUs | [Fill] | [Fill] | [Fill] |

### Error Rate Progression

| VU Level | Success Rate | Error Rate | Error Count | Primary Errors |
|----------|--------------|------------|-------------|----------------|
| 50 VUs | [Fill]% | [Fill]% | [Fill] | [List errors] |
| 100 VUs | [Fill]% | [Fill]% | [Fill] | [List errors] |
| 200 VUs | [Fill]% | [Fill]% | [Fill] | [List errors] |
| 300 VUs | [Fill]% | [Fill]% | [Fill] | [List errors] |

---

## 4. Breaking Point Analysis

### When Did Performance Degrade?

**First Signs of Stress:**
- VU Count: [Fill in]
- Symptom: [Response time increase / Errors / Timeouts]
- Threshold: [What metric crossed acceptable range]

**Significant Degradation:**
- VU Count: [Fill in]
- Impact: [Describe performance impact]
- Error Types: [List error types]

**Breaking Point (if reached):**
- VU Count: [Fill in]
- Failure Mode: [How did it fail?]
- Recovery Time: [How long to stabilize?]

### Performance Degradation Pattern

**Linear Degradation?**
- [ ] Yes - Performance decreased proportionally with load
- [ ] No - Sudden drop at certain threshold

**Degradation Graph (describe):**
```
Response Time vs Virtual Users
[Describe the pattern you observed]
```

---

## 5. Error Analysis

### Error Types Encountered

| Error Type | First Appeared At | Count | Percentage | Impact |
|------------|-------------------|-------|------------|--------|
| [Type 1] | [X VUs] | [Fill] | [Fill]% | [Fill] |
| [Type 2] | [X VUs] | [Fill] | [Fill]% | [Fill] |
| [Type 3] | [X VUs] | [Fill] | [Fill]% | [Fill] |

### Root Causes

1. **[Error Type]:** [Explanation]
2. **[Error Type]:** [Explanation]
3. **[Error Type]:** [Explanation]

---

## 6. Resource Utilization

### Server Resource Progression

| VU Level | CPU % | Memory MB | DB Connections | Notes |
|----------|-------|-----------|----------------|-------|
| Baseline | [Fill] | [Fill] | [Fill] | Before test |
| 50 VUs | [Fill] | [Fill] | [Fill] | Normal load |
| 100 VUs | [Fill] | [Fill] | [Fill] | 2x load |
| 200 VUs | [Fill] | [Fill] | [Fill] | 4x load |
| 300 VUs | [Fill] | [Fill] | [Fill] | Peak stress |
| Recovery | [Fill] | [Fill] | [Fill] | After ramp down |

### Resource Bottlenecks

**CPU:**
- Maxed out at: [X]% @ [Y] VUs
- Bottleneck: [Yes/No]

**Memory:**
- Peak usage: [X] MB @ [Y] VUs
- Leaks observed: [Yes/No]

**Database:**
- Connection pool exhausted: [Yes/No]
- Max connections: [Fill]

**Network:**
- Bandwidth limit: [Yes/No]
- I/O bottleneck: [Yes/No]

---

## 7. Recovery Analysis

### System Recovery Observation

**During Ramp Down (300 → 0 VUs):**

| Time Point | VUs | Response Time | Error Rate | Status |
|------------|-----|---------------|------------|--------|
| Start ramp down | 300 | [Fill] ms | [Fill]% | Peak stress |
| 2 min into ramp | ~180 | [Fill] ms | [Fill]% | Recovering |
| 4 min into ramp | ~60 | [Fill] ms | [Fill]% | Nearly normal |
| End (0 VUs) | 0 | [Fill] ms | [Fill]% | Recovered |

**Recovery Characteristics:**
- **Recovery Time:** [X] minutes to return to normal
- **Lingering Issues:** [Yes/No - describe]
- **Resource Cleanup:** [Immediate / Gradual / Incomplete]
- **Error Persistence:** [Did errors stop immediately or gradually?]

**Recovery Grade:** [Excellent / Good / Fair / Poor]

---

## 8. Maximum Sustainable Load

### Capacity Determination

**Definitions:**
- **Comfortable Load:** Performance meets all SLAs
- **Maximum Load:** Performance degrades but still functional
- **Breaking Point:** System becomes unreliable

**Results:**

| Load Level | VU Count | Performance | Recommendation |
|------------|----------|-------------|----------------|
| **Comfortable** | [X] VUs | [p95 < 500ms, errors < 1%] | ✅ Production ready |
| **Maximum** | [X] VUs | [p95 < 2000ms, errors < 10%] | ⚠️ Need optimization |
| **Breaking Point** | [X] VUs | [Timeouts, errors > 10%] | ❌ System failure |

**Recommended Production Limit:** [X] concurrent users

---

## 9. Findings and Recommendations

### Key Findings

1. **Breaking Point:** System reached breaking point at [X] VUs
   - Primary symptom: [Fill in]
   - Impact: [Fill in]

2. **Linear vs Non-Linear Degradation:**
   - Pattern observed: [Describe]

3. **Resource Bottleneck:**
   - Primary bottleneck: [CPU / Memory / DB / Network]
   - Secondary bottleneck: [Fill in]

4. **Error Patterns:**
   - [Describe error progression]

### Scalability Issues

**Identified Issues:**
1. [Issue 1 - e.g., "Database connection pool too small"]
2. [Issue 2 - e.g., "CPU becomes bottleneck above 200 users"]
3. [Issue 3 - e.g., "Memory leak during sustained load"]

### Recommendations

#### Immediate Actions (Critical)
1. **[Action 1]** - [Why and expected impact]
2. **[Action 2]** - [Why and expected impact]

#### Short-Term Improvements (High Priority)
1. **Increase database connections** - Current limit too low
2. **Optimize slow queries** - Reduce DB load
3. **Add caching layer** - Reduce backend hits

#### Long-Term Strategy (Architecture)
1. **Horizontal scaling** - Add more server instances
2. **Load balancer** - Distribute traffic
3. **Database read replicas** - Distribute read load
4. **CDN integration** - Offload static assets

---

## 10. Comparison with Load Test

### Load Test vs Stress Test

| Metric | Load Test (50 VUs) | Stress Test (50 VUs) | Stress Test (300 VUs) |
|--------|-------------------|---------------------|---------------------|
| p95 Response | 2.11ms | [Fill] ms | [Fill] ms |
| Error Rate | 36%* | [Fill]% | [Fill]% |
| Throughput | 70 req/s | [Fill] req/s | [Fill] req/s |

*Authentication issue in load test

### Insights from Comparison

[Write observations about how performance changed between tests]

---

## 11. Screenshots and Evidence

**Screenshots Captured:**
- [ ] Terminal output at 50 VUs
- [ ] Terminal output at 100 VUs
- [ ] Terminal output at 200 VUs
- [ ] Terminal output at 300 VUs (breaking point)
- [ ] Final summary
- [ ] Activity Monitor at peak load
- [ ] Error messages detail
- [ ] Recovery phase

**Location:** `images/assign3/stress-test-*.png`

---

## 12. Conclusion

### Summary

[Write 2-3 paragraph summary of stress test results]

**Breaking Point:** [X] concurrent users  
**Primary Bottleneck:** [Resource type]  
**Recommended Max Load:** [X] concurrent users  
**System Grade:** [A/B/C/D/F]

### Production Readiness

**Can handle expected load?**
- Expected production load: [X] users
- Tested maximum: [X] users
- Safety margin: [X]%
- Ready: [Yes/No]

**Action Required Before Production:**
1. [Action item]
2. [Action item]
3. [Action item]

---

**Test Status:** 🔄 In Progress  
**Next Test:** Spike Testing  
**Estimated Completion:** [Time]
