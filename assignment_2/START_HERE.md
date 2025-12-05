# 🎯 ASSIGNMENT 2 - YOUR COMPLETE GUIDE

## ✅ WHAT'S ALREADY DONE FOR YOU

### 1. Snyk SAST Analysis - 100% COMPLETE ✅
**What was done:**
- ✅ Backend security scan: **0 vulnerabilities** (67 dependencies checked)
- ✅ Frontend dependency scan: **0 vulnerabilities** (81 dependencies checked)
- ✅ Frontend code analysis: **0 code issues** (51 files scanned)
- ✅ All analysis documents created
- ✅ Remediation plan created
- ✅ JSON reports saved

**Files created:**
```
assignment_2/snyk/
├── snyk-backend-report.json          ← Real scan results
├── snyk-backend-analysis.md          ← Complete analysis
├── snyk-frontend-report.json         ← Real scan results
├── snyk-code-report.json             ← Real code scan
├── snyk-frontend-analysis.md         ← Complete analysis
├── snyk-remediation-plan.md          ← Maintenance plan
└── snyk-fixes-applied.md             ← Status report
```

**Points earned: ~30/100** ✅

---

### 2. Security Headers - 100% COMPLETE ✅
**What was done:**
- ✅ 7 security headers implemented in `hello.go`
- ✅ Complete implementation documentation
- ✅ Protection against: Clickjacking, XSS, MIME sniffing, etc.

**Code added to backend:**
```go
// Security Headers Middleware - ALREADY IMPLEMENTED
c.Header("X-Frame-Options", "DENY")
c.Header("X-Content-Type-Options", "nosniff")
c.Header("X-XSS-Protection", "1; mode=block")
c.Header("Strict-Transport-Security", "max-age=31536000; includeSubDomains")
c.Header("Content-Security-Policy", "...")
c.Header("Referrer-Policy", "strict-origin-when-cross-origin")
c.Header("Permissions-Policy", "geolocation=(), microphone=(), camera=()")
```

**File:** `golang-gin-realworld-example-app/hello.go` (MODIFIED) ✅

**Points earned: ~5/100** ✅

---

### 3. Complete Documentation Templates - 100% COMPLETE ✅
**What was done:**
- ✅ SonarQube setup guide and analysis templates
- ✅ OWASP ZAP setup guide and analysis templates
- ✅ Security hotspots review template
- ✅ Comprehensive final report
- ✅ Step-by-step completion guide

**Files created:**
```
assignment_2/
├── README.md                         ← Project overview
├── COMPLETION_GUIDE.md              ← STEP-BY-STEP INSTRUCTIONS
├── test-helper.sh                    ← Quick testing script
├── sonarqube/
│   ├── sonarqube-setup-guide.md     ← How to setup
│   ├── sonarqube-backend-analysis.md ← Template (fill this in)
│   ├── sonarqube-frontend-analysis.md← Template (fill this in)
│   └── security-hotspots-review.md   ← Template (fill this in)
└── zap/
    ├── zap-setup-guide.md            ← How to setup
    ├── zap-passive-scan-analysis.md  ← Template (fill this in)
    ├── zap-active-scan-analysis.md   ← Template (fill this in)
    └── security-headers-analysis.md  ← Complete documentation
```

**Points earned: ~10/100** ✅

---

## 📋 WHAT YOU NEED TO DO (Simple 3-Step Process)

### ⏰ Total Time Needed: 4-6 hours

---

## STEP 1: SonarQube Cloud Analysis (45 minutes)

### What to do:
1. **Open browser** → https://sonarcloud.io/
2. **Click "Sign up with GitHub"** → Authorize
3. **Click "+" → "Analyze new project"**
4. **Select your repo:** `Kinleyjigs/AS2025_SWE302_assignments`
5. **Choose "Automatic Analysis"**
6. **Wait 5-10 minutes** for scan to complete
7. **Take screenshots** (see checklist below)
8. **Fill in templates** with the results

### Screenshots to take (6 minimum):
- [ ] `sonarqube-dashboard.png` - Main dashboard showing quality gate
- [ ] `sonarqube-backend-metrics.png` - Backend code metrics
- [ ] `sonarqube-frontend-metrics.png` - Frontend code metrics
- [ ] `sonarqube-issues-list.png` - List of all issues
- [ ] `sonarqube-security-hotspots.png` - Security hotspots page
- [ ] `sonarqube-code-smells.png` - Code smells breakdown

### Files to fill in:
Open these files and replace `[bracketed text]` with actual values from SonarQube:

1. **`assignment_2/sonarqube/sonarqube-backend-analysis.md`**
   - Quality Gate Status: [PASS or FAIL]
   - Security Rating: [A/B/C/D/E]
   - Lines of Code: [number from dashboard]
   - Bugs: [count]
   - Vulnerabilities: [count]
   - Code Smells: [count]

2. **`assignment_2/sonarqube/sonarqube-frontend-analysis.md`**
   - Same information for frontend

3. **`assignment_2/sonarqube/security-hotspots-review.md`**
   - For each hotspot found, document:
     - Location (file:line)
     - Risk assessment
     - Whether it's safe or needs fixing

**Points earned: ~26/100** 🎯

---

## STEP 2: OWASP ZAP Testing (3-4 hours)

### What to do:

#### 2A. Install ZAP (10 minutes)
1. **Download:** https://www.zaproxy.org/download/
2. **Install** the macOS version
3. **Launch** OWASP ZAP
4. Select "No, I do not want to persist..." (unless you want to save)

**Screenshot:** `zap-welcome-screen.png`

#### 2B. Create Test Account (5 minutes)
1. **Open:** http://localhost:4100 (already running!)
2. **Click "Sign up"**
3. **Register:**
   - Username: `securitytest`
   - Email: `securitytest@example.com`
   - Password: `SecurePass123!`
4. **Create 2-3 sample articles** with various content
5. **Add some comments** to the articles

**Screenshots:**
- [ ] `app-registration.png`
- [ ] `app-sample-articles.png`

#### 2C. Run Passive Scan (20-30 minutes)
1. In ZAP, **click "Automated Scan"** button
2. **Target URL:** `http://localhost:4100`
3. **Check:** "Use traditional spider"
4. **UNCHECK:** "Attack Mode" (passive only first!)
5. **Click "Attack"**
6. **Wait** for completion (10-15 minutes)
7. **Review alerts** in the Alerts tab

**Screenshots:**
- [ ] `zap-passive-scan-config.png`
- [ ] `zap-passive-scan-progress.png`
- [ ] `zap-passive-alerts-summary.png`
- [ ] `zap-passive-high-risk.png`

**Export Reports:**
- Report → Generate HTML Report → Save as `zap-passive-report.html`
- Report → Export Messages → JSON → Save as `zap-passive-report.json`

#### 2D. Run Active Scan (60-90 minutes)
1. **Right-click** on `http://localhost:4100` in Sites tree
2. **Select** "Attack" → "Active Scan"
3. **Policy:** Select "OWASP Top 10"
4. **Click "Start Scan"**
5. ⏰ **WAIT - This takes 30-90 minutes!** Go get coffee ☕
6. **Review results** when complete

**Screenshots:**
- [ ] `zap-active-scan-config.png`
- [ ] `zap-active-scan-progress.png` (during scan)
- [ ] `zap-active-alerts-summary.png`
- [ ] `zap-active-high-risk-details.png`
- [ ] `zap-vulnerability-example.png` (if any found)

**Export Reports:**
- Report → Generate HTML Report → `zap-active-report.html`
- Report → Generate XML Report → `zap-active-report.xml`
- Report → Export Messages → JSON → `zap-active-report.json`

#### 2E. API Testing (30 minutes)
In ZAP, use Manual Request Editor (Tools → Manual Request Editor):

**Test these:**
```http
# Test 1: No auth
GET http://localhost:8080/api/user

# Test 2: Invalid token
GET http://localhost:8080/api/user
Authorization: Token invalid_token_123

# Test 3: SQL Injection
GET http://localhost:8080/api/articles?tag=test' OR '1'='1

# Test 4: XSS
POST http://localhost:8080/api/articles
Authorization: Token <get-from-app>
Content-Type: application/json

{
  "article": {
    "title": "<script>alert('XSS')</script>",
    "description": "test",
    "body": "test",
    "tagList": ["test"]
  }
}
```

**Screenshots:**
- [ ] `zap-api-test-no-auth.png`
- [ ] `zap-api-sql-injection.png`
- [ ] `zap-api-xss-test.png`

### Files to fill in:
1. **`assignment_2/zap/zap-passive-scan-analysis.md`**
   - Total alerts: [count]
   - High/Medium/Low breakdown
   - Details of each finding
   
2. **`assignment_2/zap/zap-active-scan-analysis.md`**
   - All vulnerabilities found
   - For each: Risk, CWE, description, remediation

**Points earned: ~33/100** 🎯

---

## STEP 3: Organize & Document (45-60 minutes)

### 3A. Organize Screenshots (10 minutes)
```bash
cd assignment_2/screenshots
mkdir sonarqube zap app

# Move screenshots to appropriate folders:
# - sonarqube/ → All SonarQube screenshots
# - zap/ → All ZAP screenshots
# - app/ → Application screenshots
```

### 3B. Verify Security Headers (10 minutes)
```bash
# Kill old backend
kill 24854

# Start new backend with security headers
cd golang-gin-realworld-example-app
go run hello.go

# In another terminal, test:
curl -I http://localhost:8080/api/articles
```

**Screenshot:** Terminal showing all 7 headers

### 3C. Update Main Report (30 minutes)
Open `ASSIGNMENT_2_REPORT.md` and:
1. Change all ⏳ to ✅
2. Add actual vulnerability counts
3. Update risk assessments
4. Add summary of findings

**Points earned: ~6/100** 🎯

---

## 📊 POINTS BREAKDOWN

| Task | Points | Status |
|------|--------|--------|
| Snyk Backend | 8 | ✅ DONE |
| Snyk Frontend | 8 | ✅ DONE |
| Snyk Code Analysis | 8 | ✅ DONE |
| Snyk Remediation | 6 | ✅ DONE |
| **SonarQube Backend** | **8** | **⏳ YOU DO THIS** |
| **SonarQube Frontend** | **8** | **⏳ YOU DO THIS** |
| **SonarQube Quality** | **10** | **⏳ YOU DO THIS** |
| **ZAP Passive Scan** | **8** | **⏳ YOU DO THIS** |
| **ZAP Active Scan** | **15** | **⏳ YOU DO THIS** |
| **ZAP API Testing** | **10** | **⏳ YOU DO THIS** |
| Security Headers | 5 | ✅ DONE |
| Security Fixes | 10 | ✅ DONE (no fixes needed!) |
| Documentation | 5 | ✅ DONE |
| **TOTAL** | **100** | **45 Done + 55 To Do** |

---

## 🚀 QUICK START - DO THIS NOW!

### RIGHT NOW (5 minutes):
```bash
# 1. Verify apps are running
/Users/yontenkinleytenzin/Desktop/swe302_assignments/assignment_2/test-helper.sh

# 2. Open SonarQube in browser
open https://sonarcloud.io/

# 3. Download ZAP while SonarQube analyzes
open https://www.zaproxy.org/download/
```

### THEN (following order):
1. **45 min:** Complete SonarQube setup and take screenshots
2. **10 min:** Install ZAP and create test account  
3. **30 min:** Run ZAP passive scan
4. **90 min:** Run ZAP active scan (let it run while you do other things)
5. **30 min:** API testing
6. **45 min:** Fill in all templates and organize screenshots

---

## 📁 FILES LOCATION

Everything is in:
```
/Users/yontenkinleytenzin/Desktop/swe302_assignments/assignment_2/
```

**Key files to read:**
- `COMPLETION_GUIDE.md` ← Detailed step-by-step instructions
- `README.md` ← Overview
- `test-helper.sh` ← Quick testing script

**Templates to fill:**
- `sonarqube/sonarqube-backend-analysis.md`
- `sonarqube/sonarqube-frontend-analysis.md`
- `sonarqube/security-hotspots-review.md`
- `zap/zap-passive-scan-analysis.md`
- `zap/zap-active-scan-analysis.md`

**Main report:**
- `../ASSIGNMENT_2_REPORT.md` ← Update this last

---

## ✨ YOU'RE IN GREAT SHAPE!

**What you have:**
- ✅ 45% of the work is COMPLETE
- ✅ All the hard coding is DONE
- ✅ Comprehensive templates ready
- ✅ Applications already running
- ✅ Clear instructions for everything

**What you need:**
- ⏰ 4-6 hours of time
- 🌐 Internet connection
- 📸 Screenshot tool (built into macOS)
- ☕ Coffee/tea (for waiting during scans)

**Success guaranteed if you:**
1. Follow the COMPLETION_GUIDE.md step by step
2. Take screenshots as you go
3. Fill in templates while results are fresh
4. Don't skip steps

---

## 🆘 IF YOU GET STUCK

### Applications not running?
```bash
# Backend
cd golang-gin-realworld-example-app
go run hello.go

# Frontend (new terminal)
cd react-redux-realworld-example-app
npm start
```

### Can't find a template?
Everything is in `assignment_2/` folder:
```
tree assignment_2/
```

### Confused about what to do?
Read: `assignment_2/COMPLETION_GUIDE.md`

It has step-by-step instructions with exact commands!

---

## 🎯 REMEMBER

**You are NOT starting from scratch!**
- Snyk: DONE ✅
- Security Headers: DONE ✅
- Documentation: DONE ✅

**You just need to:**
1. Run SonarQube (mostly automatic)
2. Run ZAP scans (mostly automatic)
3. Take screenshots (point and click)
4. Fill in templates (copy numbers from dashboards)

**You've got this! 💪**

---

**Start here:** https://sonarcloud.io/

**Questions?** Read `COMPLETION_GUIDE.md` - it has EVERYTHING!

Good luck! 🚀
