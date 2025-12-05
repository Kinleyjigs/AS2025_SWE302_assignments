# Assignment 2 - Step-by-Step Completion Guide

## Current Status ✅

**Applications Running:**
- ✅ Backend: http://localhost:8080 (PID: 24854)
- ✅ Frontend: http://localhost:4100 (PID: 25680)

**Completed:**
- ✅ Snyk scans (all 3 scans complete with 0 vulnerabilities)
- ✅ Security headers implemented
- ✅ All documentation templates created

**Remaining:**
- ⏳ SonarQube Cloud setup and analysis
- ⏳ OWASP ZAP testing
- ⏳ Screenshots collection

---

## Task 1: SonarQube Cloud Setup (30-45 minutes)

### Step 1.1: Create Account
1. Open browser: https://sonarcloud.io/
2. Click **"Sign up"** or **"Log in with GitHub"**
3. Authorize SonarQube Cloud with your GitHub account
4. **Screenshot:** `sonarqube-login.png`

### Step 1.2: Import Repository
1. Click **"+"** button in top-right corner
2. Select **"Analyze new project"**
3. Choose **"Import from GitHub"**
4. Find and select: `Kinleyjigs/AS2025_SWE302_assignments`
5. Click **"Set up"**
6. **Screenshot:** `sonarqube-project-import.png`

### Step 1.3: Configure Analysis Method
**Option 1: Automatic Analysis (Easiest)**
1. Select **"With SonarQube Cloud Automatic Analysis"**
2. Enable automatic analysis
3. Wait for first scan (5-10 minutes)
4. **Screenshot:** `sonarqube-automatic-analysis.png`

**Option 2: Manual Scanner (More Control)**
1. Select **"With SonarQube Scanner"**
2. Download scanner for macOS
3. Create configuration files (instructions provided)

### Step 1.4: View Backend Results
1. Once analysis completes, go to your project
2. Navigate to backend code metrics
3. **Screenshots to take:**
   - `sonarqube-backend-dashboard.png` - Main dashboard
   - `sonarqube-backend-overview.png` - Overview tab
   - `sonarqube-backend-issues.png` - Issues tab
   - `sonarqube-backend-security.png` - Security hotspots

### Step 1.5: View Frontend Results
1. Navigate to frontend code metrics
2. **Screenshots to take:**
   - `sonarqube-frontend-dashboard.png` - Main dashboard
   - `sonarqube-frontend-issues.png` - Issues breakdown
   - `sonarqube-frontend-security.png` - Security hotspots
   - `sonarqube-frontend-code-smells.png` - Code smells

### Step 1.6: Document Findings
1. Open `assignment_2/sonarqube/sonarqube-frontend-analysis.md`
2. Fill in all `[bracketed]` sections with actual values from dashboard:
   - Quality Gate Status
   - Security/Reliability/Maintainability Ratings
   - Lines of Code
   - Bugs, Vulnerabilities, Code Smells counts
   - Coverage percentage
   - Duplication percentage

3. Open `assignment_2/sonarqube/sonarqube-backend-analysis.md`
4. Fill in the same information for backend

5. Open `assignment_2/sonarqube/security-hotspots-review.md`
6. For each security hotspot found:
   - Document location
   - Assess risk
   - Determine if safe or at risk
   - Add recommendation

---

## Task 2: OWASP ZAP Setup (15 minutes)

### Step 2.1: Install ZAP
**Option 1: Download Desktop App (Recommended)**
1. Visit: https://www.zaproxy.org/download/
2. Download **ZAP for macOS**
3. Install and launch application
4. **Screenshot:** `zap-installation.png`

**Option 2: Use Docker**
```bash
docker pull zaproxy/zap-stable
docker run -u zap -p 8080:8080 -i zaproxy/zap-stable zap.sh -daemon -host 0.0.0.0 -port 8080
```

### Step 2.2: Initial ZAP Setup
1. Launch OWASP ZAP
2. When asked about session persistence:
   - For learning: Select **"No, I do not want to persist..."**
   - For saving work: Create new session in `assignment_2/zap/`
3. **Screenshot:** `zap-welcome-screen.png`

---

## Task 3: Create Test User Account (5 minutes)

### Step 3.1: Register Test Account
1. Open browser: http://localhost:4100
2. Click **"Sign up"** in top navigation
3. Register with:
   - **Username:** `securitytest`
   - **Email:** `securitytest@example.com`
   - **Password:** `SecurePass123!`
4. **Screenshot:** `app-registration.png`

### Step 3.2: Create Sample Data
1. After login, click **"New Article"**
2. Create 2-3 sample articles with:
   - Title: Various test titles
   - Description: Short descriptions
   - Body: Some content
   - Tags: test, security, sample
3. Add some comments to articles
4. **Screenshot:** `app-sample-articles.png`

---

## Task 4: ZAP Passive Scan (30 minutes)

### Step 4.1: Configure Browser Proxy (Optional but Recommended)
1. Configure browser to use proxy: `localhost:8080`
2. Or use ZAP's built-in browser

### Step 4.2: Run Automated Scan
1. In ZAP, click **"Automated Scan"** button
2. Enter target URL: `http://localhost:4100`
3. Select **"Use traditional spider"**
4. **UNCHECK** "Attack Mode" (passive scan only)
5. Click **"Attack"**
6. Wait for scan to complete (5-10 minutes)
7. **Screenshot:** `zap-passive-scan-progress.png`

### Step 4.3: Review Passive Scan Results
1. Click on **"Alerts"** tab at bottom
2. Review all findings by risk level
3. **Screenshots:**
   - `zap-passive-alerts-summary.png` - Overall alerts
   - `zap-passive-high-risk.png` - High risk findings
   - `zap-passive-medium-risk.png` - Medium risk findings
   - `zap-passive-missing-headers.png` - Security headers

### Step 4.4: Export Passive Scan Report
1. Go to **"Report"** > **"Generate HTML Report"**
2. Save as: `assignment_2/zap/zap-passive-report.html`
3. Go to **"Report"** > **"Export Messages to File..."**
4. Format: **JSON**
5. Save as: `assignment_2/zap/zap-passive-report.json`

### Step 4.5: Document Passive Scan Findings
1. Open `assignment_2/zap/zap-passive-scan-analysis.md`
2. Fill in:
   - Total alerts count
   - Breakdown by risk level
   - Details of each high/medium finding
   - URLs affected
   - Recommendations

---

## Task 5: ZAP Active Scan with Authentication (90-120 minutes)

### Step 5.1: Create Context
1. In ZAP menu: **"Analyse"** > **"Show Session Properties"**
2. In left panel, click **"Contexts"**
3. Click **"+"** button to add new context
4. Name: `Conduit Authenticated`
5. **Screenshot:** `zap-context-creation.png`

### Step 5.2: Include URLs in Context
1. In context properties, select **"Include in Context"** tab
2. Click **"Add"**
3. Enter regex: `http://localhost:4100.*`
4. Click **"Add"** again
5. Enter regex: `http://localhost:8080/api.*`
6. **Screenshot:** `zap-context-urls.png`

### Step 5.3: Configure Authentication

**IMPORTANT:** The RealWorld API uses JWT authentication. Here's how to set it up:

1. In context properties, go to **"Authentication"** tab
2. Select **"Script-based Authentication"**
3. Load script: **"authentication/HttpSenderAuthentication.js"**
4. Or use **"Manual Authentication"** and we'll handle tokens manually

**Manual Approach (Easier):**
1. Get your JWT token:
   - Open browser DevTools (F12)
   - Go to Application/Storage > Local Storage
   - Find the token after logging in
   - Copy the token value
   
2. In ZAP, for each request:
   - Right-click request
   - "Resend..."
   - Add header: `Authorization: Token <your-jwt-token>`

**Screenshot:** `zap-authentication-setup.png`

### Step 5.4: Spider as User
1. Right-click on `http://localhost:4100` in Sites tree
2. Select **"Attack"** > **"Spider..."**
3. Check **"Use Context"**: Conduit Authenticated
4. Click **"Start Scan"**
5. Wait for completion (10-15 minutes)
6. **Screenshot:** `zap-spider-progress.png`

### Step 5.5: Active Scan
1. Right-click on `http://localhost:4100` in Sites tree
2. Select **"Attack"** > **"Active Scan..."**
3. Select **"Policy"**: **OWASP Top 10**
4. Select **"Context"**: Conduit Authenticated
5. Click **"Start Scan"**
6. ⚠️ **This will take 30-90 minutes!**
7. **Screenshots:**
   - `zap-active-scan-config.png` - Configuration
   - `zap-active-scan-progress.png` - Scan in progress
   - `zap-active-scan-50percent.png` - Midway screenshot

### Step 5.6: Review Active Scan Results
1. Once complete, review **"Alerts"** tab
2. Focus on high and critical findings
3. **Screenshots:**
   - `zap-active-alerts-summary.png` - All alerts
   - `zap-active-high-risk-details.png` - High risk details
   - `zap-active-sql-injection.png` - If SQL injection found
   - `zap-active-xss.png` - If XSS found
   - `zap-active-idor.png` - If access control issues found

### Step 5.7: Export Active Scan Reports
1. **"Report"** > **"Generate HTML Report"**
   - Save: `assignment_2/zap/zap-active-report.html`
2. **"Report"** > **"Generate XML Report"**
   - Save: `assignment_2/zap/zap-active-report.xml`
3. **"Report"** > **"Export Messages to File..."**
   - Format: JSON
   - Save: `assignment_2/zap/zap-active-report.json`

### Step 5.8: Document Active Scan Findings
1. Open `assignment_2/zap/zap-active-scan-analysis.md`
2. For each vulnerability found:
   - Vulnerability name
   - Risk level
   - CWE/OWASP category
   - Affected URLs
   - Attack payload used
   - Response received
   - Impact assessment
   - Remediation steps

---

## Task 6: API Security Testing (30-45 minutes)

### Step 6.1: Manual API Tests

**Test 1: Authentication Bypass**
1. In ZAP, go to **"Manual Request Editor"** (Ctrl+M or Cmd+M)
2. Test accessing protected endpoints without token:

```http
GET http://localhost:8080/api/user
```

3. Expected: 401 Unauthorized
4. **Screenshot:** `zap-api-test-no-auth.png`

**Test 2: Invalid Token**
```http
GET http://localhost:8080/api/user
Authorization: Token invalid_token_12345
```

**Test 3: IDOR (Insecure Direct Object Reference)**
1. Create article as your user (note the slug)
2. Try to delete it with different/invalid token
3. Expected: Should fail with 403 or 401

```http
DELETE http://localhost:8080/api/articles/your-article-slug
Authorization: Token different_user_token
```

**Screenshot:** `zap-api-idor-test.png`

**Test 4: SQL Injection**
```http
GET http://localhost:8080/api/articles?tag=test' OR '1'='1
GET http://localhost:8080/api/articles?author=' UNION SELECT * FROM users--
```

**Screenshot:** `zap-api-sql-injection-test.png`

**Test 5: XSS in Article Content**
```http
POST http://localhost:8080/api/articles
Authorization: Token <your-token>
Content-Type: application/json

{
  "article": {
    "title": "<script>alert('XSS')</script>",
    "description": "XSS test",
    "body": "<img src=x onerror=alert('XSS')>",
    "tagList": ["xss"]
  }
}
```

**Screenshot:** `zap-api-xss-test.png`

### Step 6.2: Use ZAP Fuzzer
1. Right-click on a request in History
2. Select **"Attack"** > **"Fuzz..."**
3. Highlight parameter to fuzz
4. Click **"Add"**
5. Select payload list (e.g., "jbrofuzz/SQL Injection")
6. Click **"Start Fuzzer"**
7. **Screenshot:** `zap-fuzzer-config.png`
8. Review results
9. **Screenshot:** `zap-fuzzer-results.png`

---

## Task 7: Verify Security Headers (10 minutes)

### Step 7.1: Test Headers with curl
```bash
curl -I http://localhost:8080/api/ping
```

**Screenshot:** Take terminal screenshot showing all headers

### Step 7.2: Test in Browser
1. Open DevTools (F12)
2. Go to Network tab
3. Visit: http://localhost:8080/api/ping
4. Click on the request
5. View Response Headers
6. **Screenshot:** `security-headers-browser-devtools.png`

### Step 7.3: Re-run ZAP Passive Scan
1. Clear previous results or create new session
2. Run passive scan again
3. Verify security header alerts are now resolved
4. **Screenshot:** `zap-passive-after-headers.png`

### Step 7.4: Before/After Comparison
Create a document showing:
- Before: Missing headers alerts
- After: Headers present

---

## Task 8: Organize Screenshots (15 minutes)

### Step 8.1: Create Screenshot Directory Structure
```bash
cd assignment_2/screenshots
mkdir sonarqube
mkdir zap
mkdir app
mkdir headers
```

### Step 8.2: Move Screenshots
Move all screenshots to appropriate folders:
- `sonarqube/` - All SonarQube screenshots
- `zap/` - All ZAP screenshots
- `app/` - Application screenshots
- `headers/` - Security headers verification

### Step 8.3: Create Screenshot Index
Create `assignment_2/screenshots/README.md` listing all screenshots with descriptions.

---

## Task 9: Final Documentation (30-45 minutes)

### Step 9.1: Complete SonarQube Analysis
- [ ] Fill in `sonarqube-frontend-analysis.md`
- [ ] Fill in `sonarqube-backend-analysis.md`
- [ ] Complete `security-hotspots-review.md`

### Step 9.2: Complete ZAP Analysis
- [ ] Fill in `zap-passive-scan-analysis.md`
- [ ] Fill in `zap-active-scan-analysis.md`
- [ ] Update `security-headers-analysis.md` with verification

### Step 9.3: Update Main Report
1. Open `ASSIGNMENT_2_REPORT.md`
2. Update all "⏳ Pending" statuses to "✅ Complete"
3. Add actual findings counts
4. Update risk assessments based on real findings
5. Add executive summary of all findings

---

## Quick Reference: Essential Screenshots Checklist

### SonarQube (6 screenshots minimum)
- [ ] `sonarqube-dashboard.png` - Main dashboard
- [ ] `sonarqube-backend-overview.png` - Backend metrics
- [ ] `sonarqube-frontend-overview.png` - Frontend metrics
- [ ] `sonarqube-issues.png` - Issues list
- [ ] `sonarqube-security-hotspots.png` - Security hotspots
- [ ] `sonarqube-code-quality.png` - Code quality metrics

### OWASP ZAP (10 screenshots minimum)
- [ ] `zap-welcome.png` - Initial screen
- [ ] `zap-passive-scan.png` - Passive scan results
- [ ] `zap-passive-alerts.png` - Passive alerts summary
- [ ] `zap-context-setup.png` - Authentication context
- [ ] `zap-active-scan-progress.png` - Active scan running
- [ ] `zap-active-alerts.png` - Active scan results
- [ ] `zap-high-risk-detail.png` - Example high-risk finding
- [ ] `zap-api-tests.png` - API testing
- [ ] `zap-fuzzer.png` - Fuzzer configuration
- [ ] `zap-final-report.png` - Final assessment

### Application (3 screenshots minimum)
- [ ] `app-registration.png` - User registration
- [ ] `app-logged-in.png` - Logged in state
- [ ] `app-sample-data.png` - Sample articles created

### Security Headers (2 screenshots minimum)
- [ ] `headers-before.png` - Missing headers in ZAP
- [ ] `headers-after.png` - Headers present after implementation
- [ ] `headers-browser-devtools.png` - Headers in browser

---

## Time Estimates

| Task | Estimated Time |
|------|----------------|
| SonarQube Setup | 30-45 min |
| SonarQube Analysis | 15-20 min |
| ZAP Installation | 10-15 min |
| Create Test Account | 5 min |
| ZAP Passive Scan | 20-30 min |
| ZAP Active Scan | 60-90 min |
| API Security Testing | 30-45 min |
| Screenshots Organization | 15 min |
| Documentation | 45-60 min |
| **TOTAL** | **4-6 hours** |

---

## Tips for Success

### General
1. **Take screenshots as you go** - Don't wait until the end
2. **Name screenshots clearly** - Use descriptive names
3. **Save all reports** - HTML, JSON, XML formats
4. **Document while testing** - Don't rely on memory

### SonarQube
- Let automatic analysis run completely
- Review each category of issues
- Pay special attention to security hotspots
- Compare with Snyk results

### OWASP ZAP
- Start with passive scan (safe, non-intrusive)
- Let active scan run uninterrupted (can take time)
- Focus on high and critical findings
- Verify each finding manually (false positives exist)
- Save your session regularly

### Screenshots
- Use high resolution
- Capture full window when relevant
- Highlight important areas
- Include timestamps when possible
- Organize immediately

---

## Troubleshooting

### SonarQube Issues
**Problem:** Analysis not starting
- **Solution:** Check GitHub permissions, refresh page

**Problem:** No code detected
- **Solution:** Ensure repository is public or properly connected

### ZAP Issues
**Problem:** Can't connect to application
- **Solution:** Verify both apps are running (check ports 8080 and 4100)

**Problem:** Active scan too slow
- **Solution:** Reduce scan policy, lower thread count

**Problem:** Authentication not working
- **Solution:** Use manual token approach instead of auto-auth

### Application Issues
**Problem:** Backend not starting
- **Solution:** Port might be in use, kill process or use different port

**Problem:** Frontend not starting
- **Solution:** Run `npm install` then `npm start`

---

## Final Checklist

Before submitting, ensure:

### Files
- [ ] All Snyk reports present (JSON files)
- [ ] All analysis documents filled in
- [ ] All ZAP reports exported (HTML, JSON, XML)
- [ ] Security headers implemented in code
- [ ] Main report updated with findings
- [ ] README.md updated

### Screenshots
- [ ] Minimum 20 screenshots taken
- [ ] All screenshots properly named
- [ ] Screenshots organized in folders
- [ ] Screenshot index created

### Documentation
- [ ] No [bracketed] placeholders remaining
- [ ] All findings documented
- [ ] Recommendations provided
- [ ] Before/after comparisons included
- [ ] Risk assessments completed

### Testing
- [ ] SonarQube analysis complete
- [ ] ZAP passive scan complete
- [ ] ZAP active scan complete
- [ ] API security tests performed
- [ ] Security headers verified

---

## Need Help?

Reference these files:
- `assignment_2/README.md` - Project overview
- `sonarqube/sonarqube-setup-guide.md` - Detailed SonarQube steps
- `zap/zap-setup-guide.md` - Detailed ZAP steps
- `ASSIGNMENT_2_REPORT.md` - Main report template

Good luck! 🚀

**Remember:** The applications are already running at:
- Backend: http://localhost:8080
- Frontend: http://localhost:4100

You can start testing immediately!
