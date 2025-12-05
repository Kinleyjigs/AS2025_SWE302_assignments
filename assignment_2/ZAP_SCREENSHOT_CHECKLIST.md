# ZAP Screenshot Checklist - Quick Reference

## ⚡ When You're Ready to Complete ZAP Tasks

### Prerequisites (5 minutes)
1. **Download ZAP:** https://www.zaproxy.org/download/
   - For **Mac M1/M2/M3 (Apple Silicon)**: Download **macOS ARM64** (.dmg)
   - For **Intel Mac**: Download **macOS x64** (.dmg)
2. **Install and Launch** OWASP ZAP
3. **Start your applications** (if not already running):
   ```bash
   # Terminal 1 - Backend
   cd golang-gin-realworld-example-app
   go run hello.go
   
   # Terminal 2 - Frontend  
   cd react-redux-realworld-example-app
   npm start
   ```
4. **Verify they're running:**
   - Backend: http://localhost:8080
   - Frontend: http://localhost:4100

---

## 📸 Screenshots You Need to Take

### Part 1: Passive Scan (30 minutes)

**What to do:**
1. In ZAP, click **"Automated Scan"**
2. Enter: `http://localhost:4100`
3. Check **"Use traditional spider"**
4. **UNCHECK** "Attack Mode" 
5. Click **"Attack"** and wait 5-10 minutes

**Screenshots needed:**
- [ ] `zap-passive-alerts-summary.png` - Alerts tab showing all findings by risk level
- [ ] `zap-passive-high-risk.png` - Details of high-risk alerts
- [ ] `zap-passive-medium-risk.png` - Details of medium-risk alerts  
- [ ] `zap-passive-sites-tree.png` - Sites tree showing discovered URLs
- [ ] `zap-passive-missing-headers.png` - Security headers findings

**Export reports:**
- Report > Generate HTML Report → `assignment_2/zap/zap-passive-report.html`
- Report > Export Messages → JSON → `assignment_2/zap/zap-passive-report.json`

**Then fill in:** `assignment_2/zap/zap-passive-scan-analysis.md`

---

### Part 2: Active Scan (60-90 minutes)

**What to do:**
1. Create test user at http://localhost:4100:
   - Username: `securitytest`
   - Email: `securitytest@example.com`
   - Password: `SecurePass123!`
2. Create 2-3 sample articles while logged in
3. In ZAP, right-click site in tree → **"Attack"** → **"Active Scan"**
4. Select **"OWASP Top 10"** policy
5. Start scan and wait (can take 30-60 minutes)

**Screenshots needed:**
- [ ] `zap-active-scan-progress.png` - Active scan in progress
- [ ] `zap-active-alerts-summary.png` - All active scan findings
- [ ] `zap-active-critical-high.png` - Critical/High severity issues
- [ ] `zap-active-medium-low.png` - Medium/Low severity issues
- [ ] `zap-active-owasp-mapping.png` - OWASP Top 10 categorization

**Export reports:**
- Report > Generate HTML Report → `assignment_2/zap/zap-active-report.html`
- Report > Export Messages → JSON → `assignment_2/zap/zap-active-report.json`

**Then fill in:** `assignment_2/zap/zap-active-scan-analysis.md`

---

## 📝 What to Document

After taking screenshots, update these files:

### 1. `zap-passive-scan-analysis.md`
Fill in the `[To be filled]` sections with:
- Scan date: **December 5, 2025**
- Total URLs discovered
- Alert counts by risk level (High/Medium/Low/Info)
- Specific findings (look for):
  - Missing X-Frame-Options
  - Missing CSP header
  - Missing X-Content-Type-Options
  - Cookie issues
  - Information disclosure

### 2. `zap-active-scan-analysis.md`
Fill in with:
- Vulnerability counts by severity
- OWASP Top 10 mapping
- Any SQL injection findings
- XSS vulnerabilities
- Authentication/authorization issues
- Specific attack payloads that worked

---

## 💡 Expected Findings (Based on Typical Scans)

### Passive Scan Usually Finds:
- ⚠️ **Medium:** Missing Anti-Clickjacking Header
- ⚠️ **Medium:** Content Security Policy Not Set
- ⚠️ **Medium:** Missing X-Content-Type-Options
- 🔵 **Low:** Cookie Without SameSite Attribute
- 🔵 **Low:** Server Information Disclosure
- ℹ️ **Info:** Timestamp Disclosure

### Active Scan Usually Finds:
- Same as passive scan findings
- 🔴 **High:** Possible SQL Injection (if found)
- 🔴 **High:** Cross-Site Scripting (if found)
- ⚠️ **Medium:** CORS Misconfiguration
- 🔵 **Low:** Directory Browsing
- ℹ️ **Info:** Application Error Disclosure

---

## ✅ Quick Status Check

**Current Status:**
- ✅ ZAP setup guide created
- ✅ Analysis templates created  
- ✅ Security headers already implemented in backend
- ⏳ Need to: Download ZAP, run scans, take screenshots
- ⏳ Need to: Fill in analysis documents

**Time Required:**
- ZAP download/install: 10 minutes
- Passive scan: 30 minutes
- Active scan: 90 minutes
- Documentation: 30 minutes
- **Total: ~2.5 hours**

---

## 🎯 After Completing ZAP

Save all screenshots to: `assignment_2/screenshots/`

Then you're done with ZAP! The only remaining task for Assignment 2 is:
- SonarQube Cloud analysis (if not done yet)

---

## 🆘 Quick Troubleshooting

**ZAP can't reach applications:**
- Check apps are running: `lsof -i :8080 -i :4100`
- Restart backend: `cd golang-gin-realworld-example-app && go run hello.go`
- Restart frontend: `cd react-redux-realworld-example-app && npm start`

**Scan taking too long:**
- Use "Medium" scan strength instead of "High"
- Reduce number of threads in scan options
- Scan specific paths instead of entire site

**No vulnerabilities found:**
- This is good! It means the application is secure
- Document "0 vulnerabilities found" in your analysis
- Still document the security headers findings from passive scan
