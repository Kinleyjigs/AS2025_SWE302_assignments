# OWASP ZAP - Setup and Testing Guide

## Overview

OWASP ZAP (Zed Attack Proxy) is a free, open-source dynamic application security testing (DAST) tool. This guide covers setting up ZAP and running comprehensive security tests on the RealWorld Conduit application.

## Installation

### Option 1: Desktop Application (Recommended)

1. Visit [https://www.zaproxy.org/download/](https://www.zaproxy.org/download/)
2. Download ZAP for macOS
3. Install the application
4. Launch OWASP ZAP

### Option 2: Docker

```bash
# Pull the ZAP stable image
docker pull zaproxy/zap-stable

# Run ZAP in daemon mode
docker run -u zap -p 8080:8080 -p 8090:8090 -i zaproxy/zap-stable zap.sh -daemon -host 0.0.0.0 -port 8080 -config api.addrs.addr.name=.* -config api.addrs.addr.regex=true
```

## Prerequisites

### Start the Full Stack Application

You need both backend and frontend running before testing with ZAP.

#### Terminal 1: Start Backend
```bash
cd /Users/yontenkinleytenzin/Desktop/swe302_assignments/golang-gin-realworld-example-app
go run hello.go
```

Backend should be running on `http://localhost:8080`

#### Terminal 2: Start Frontend
```bash
cd /Users/yontenkinleytenzin/Desktop/swe302_assignments/react-redux-realworld-example-app
npm start
```

Frontend should be running on `http://localhost:4100`

### Create Test User

1. Open browser: `http://localhost:4100`
2. Click "Sign up"
3. Register test account:
   - **Username:** `security-test`
   - **Email:** `security-test@example.com`
   - **Password:** `SecurePass123!`
4. Create a few sample articles for testing
5. Document credentials (you'll need them for ZAP)

## Part 1: Passive Scan

Passive scanning observes traffic without actively attacking the application.

### Steps:

1. **Open OWASP ZAP**

2. **Configure ZAP**
   - Select "No, I do not want to persist this session" (for learning)
   - Or create a new session to save your work

3. **Start Automated Scan**
   - Click "Automated Scan" button
   - Enter URL: `http://localhost:4100`
   - Check "Use traditional spider"
   - Uncheck "Use AJAX Spider" (can enable later)
   - Uncheck "Attack Mode" (passive scan only first)
   - Click "Attack"

4. **Manual Browsing (Recommended)**
   - Configure your browser to use ZAP proxy (localhost:8080)
   - Browse the application manually
   - ZAP will passively scan all traffic

### Expected Passive Scan Findings

Based on typical web applications, expect to find:

#### High Priority Issues:
- Missing Anti-clickjacking Header (X-Frame-Options)
- Missing Content Security Policy (CSP)
- Missing X-Content-Type-Options Header

#### Medium Priority Issues:
- Cookie Without SameSite Attribute
- Cookie Without Secure Flag
- Incomplete or No Cache-control Header Set

#### Low/Informational:
- Server Leaks Information via "X-Powered-By" Header
- Timestamp Disclosure
- Information Disclosure - Debug Error Messages

### Take Screenshots

**Required Screenshots:**
1. `zap-passive-scan-alerts-summary.png` - Alerts summary by risk level
2. `zap-passive-scan-alert-details.png` - Details of a high-risk finding
3. `zap-passive-scan-sites-tree.png` - Sites tree showing scanned URLs

Save to: `assignment_2/screenshots/`

### Export Passive Scan Report

```
Report > Generate HTML Report
Save as: assignment_2/zap/zap-passive-report.html

Report > Export Messages to File
Format: JSON
Save as: assignment_2/zap/zap-passive-report.json
```

## Part 2: Active Scan (Unauthenticated)

Active scanning actively probes the application for vulnerabilities.

### Steps:

1. **Run Passive Scan First** (to discover URLs)

2. **Select Target**
   - In Sites tree, right-click on `http://localhost:4100`
   - Select "Attack" > "Active Scan"

3. **Configure Active Scan**
   - Policy: "OWASP Top 10"
   - Scan Strength: Medium (to start)
   - Click "Start Scan"

4. **Wait for Completion**
   - Active scans can take 20-60 minutes
   - Monitor progress in the bottom panel

### Expected Findings (Unauthenticated)

- Missing security headers (same as passive)
- Potential CORS misconfiguration
- Information disclosure in error messages
- Directory browsing
- Source code disclosure

## Part 3: Active Scan (Authenticated)

This is the most important scan for finding security vulnerabilities in protected functionality.

### Step 1: Configure Context

1. **Create Context**
   - Top menu: Analyse > Show Session Properties
   - Click "+" to create new context
   - Name: "Conduit Authenticated"

2. **Include URLs in Context**
   - In "Include in Context" tab
   - Add regex: `http://localhost:4100.*`
   - Add regex: `http://localhost:8080/api.*`

### Step 2: Configure Authentication

The RealWorld API uses JWT token authentication.

1. **Set Authentication Method**
   - In Context properties, go to "Authentication" tab
   - Method: "JSON-based Authentication"

2. **Configure Login Request**
   - Login URL: `http://localhost:8080/api/users/login`
   - Login Request POST Data:
```json
{"user":{"email":"security-test@example.com","password":"SecurePass123!"}}
```
   - Username Parameter: `user.email`
   - Password Parameter: `user.password`

3. **Configure Token Extraction**
   - In "Logged In Indicator" field: `"token"`
   - Or use regex: `"user":\s*{[^}]*"token":\s*"([^"]+)"`

### Step 3: Configure Session Management

1. **Session Management Method**
   - Method: "HTTP Authentication"
   - Or: "Script-based Session Management" (for more control)

2. **Add Authorization Header**
   - The application expects: `Authorization: Token <jwt_token>`
   - Configure in "Session Properties"

### Step 4: Create User

1. **Add User to Context**
   - In "Users" tab
   - Click "Add"
   - Username: `security-test@example.com`
   - Enable user

2. **Set User Credentials**
   - Username: `security-test@example.com`
   - Password: `SecurePass123!`

### Step 5: Spider as User

1. **Spider with Context**
   - Right-click on `http://localhost:4100`
   - Select "Attack" > "Spider as User"
   - Select context and user
   - Click "Start Spider"

This discovers all authenticated pages.

### Step 6: Active Scan as User

1. **Run Active Scan**
   - Right-click on `http://localhost:4100`
   - Select "Attack" > "Active Scan"
   - Check "Show advanced options"
   - Select Context: "Conduit Authenticated"
   - Select User: security-test@example.com
   - Policy: "OWASP Top 10"
   - Click "Start Scan"

2. **Monitor Scan**
   - This will take 30-60 minutes
   - Watch for findings in the Alerts tab

### Expected Authenticated Scan Findings

#### Potential High/Critical Issues:
- **SQL Injection** - In article search, tags, etc.
- **Cross-Site Scripting (XSS)** - In article content, comments, user bio
- **Insecure Direct Object References** - Accessing other users' articles
- **Missing Function Level Access Control** - API endpoints without proper auth
- **Broken Authentication** - Token validation issues

#### Potential Medium Issues:
- **CSRF** - Missing CSRF tokens
- **Information Disclosure** - Verbose error messages
- **Security Misconfiguration** - Default settings

### Take Screenshots

**Required Screenshots:**
1. `zap-active-scan-progress.png` - Active scan in progress
2. `zap-active-scan-alerts.png` - All alerts found
3. `zap-active-scan-high-risk.png` - Details of high-risk vulnerability
4. `zap-active-scan-sites-auth.png` - Authenticated pages discovered

Save to: `assignment_2/screenshots/`

### Export Active Scan Reports

```bash
# Generate reports in multiple formats
Report > Generate HTML Report
Save as: assignment_2/zap/zap-active-report.html

Report > Generate XML Report  
Save as: assignment_2/zap/zap-active-report.xml

Report > Generate JSON Report
Save as: assignment_2/zap/zap-active-report.json
```

## Part 4: API Security Testing

### API Endpoints to Test

Test all major API endpoints:

```
Authentication:
POST   /api/users                  # Register
POST   /api/users/login            # Login
GET    /api/user                   # Current user
PUT    /api/user                   # Update user

Profiles:
GET    /api/profiles/:username     # Get profile
POST   /api/profiles/:username/follow
DELETE /api/profiles/:username/follow

Articles:
GET    /api/articles               # List articles
POST   /api/articles               # Create article
GET    /api/articles/:slug         # Get article
PUT    /api/articles/:slug         # Update article
DELETE /api/articles/:slug         # Delete article
POST   /api/articles/:slug/favorite
DELETE /api/articles/:slug/favorite

Comments:
GET    /api/articles/:slug/comments
POST   /api/articles/:slug/comments
DELETE /api/articles/:slug/comments/:id

Tags:
GET    /api/tags
```

### Manual API Testing with ZAP

1. **Use Manual Request Editor**
   - Tools > Manual Request Editor
   - Or use ZAP's Request/Response panes

2. **Test for Common API Vulnerabilities:**

#### A. Authentication Bypass
```bash
# Try accessing protected endpoints without token
GET /api/user
# Expected: 401 Unauthorized

# Try with invalid token
GET /api/user
Authorization: Token invalid_token_here
# Expected: 401 Unauthorized

# Try accessing other users' resources
GET /api/articles/other-user-article-slug
DELETE /api/articles/other-user-article-slug
# Expected: 403 Forbidden or proper authorization check
```

#### B. Authorization Flaws (IDOR)
```bash
# Try to modify another user's article
PUT /api/articles/:someone-elses-slug
Authorization: Token <your_valid_token>
Content-Type: application/json

{"article":{"title":"Hacked Title"}}

# Expected: 403 Forbidden or 404 Not Found
```

#### C. Input Validation
```bash
# SQL Injection in query parameters
GET /api/articles?tag=test' OR '1'='1
GET /api/articles?author=' UNION SELECT * FROM users--

# XSS in article content
POST /api/articles
Authorization: Token <token>
Content-Type: application/json

{
  "article": {
    "title": "<script>alert('XSS')</script>",
    "description": "Test",
    "body": "<img src=x onerror=alert('XSS')>",
    "tagList": ["<script>alert('XSS')</script>"]
  }
}
```

#### D. Rate Limiting
```bash
# Use ZAP Fuzzer to send many requests
# Right-click a request > Attack > Fuzz
# Set payloads and send 100+ requests
# Check if rate limiting is enforced
```

#### E. Information Disclosure
```bash
# Check error responses for sensitive info
GET /api/articles/nonexistent-slug
DELETE /api/articles/invalid-slug

# Look for:
# - Stack traces
# - Database errors
# - Internal file paths
# - Version information
```

### Fuzzing for Vulnerabilities

1. **Select Request to Fuzz**
   - Right-click on request in History
   - Select "Attack" > "Fuzz"

2. **Add Fuzz Locations**
   - Highlight parameter to fuzz
   - Click "Add"
   - Select payload type:
     - SQL Injection
     - XSS
     - Command Injection
     - Path Traversal

3. **Run Fuzzer**
   - Click "Start Fuzzer"
   - Monitor results for successful attacks

### Take Screenshots

**Required Screenshots:**
1. `zap-api-endpoints.png` - API endpoints discovered
2. `zap-api-vulnerability.png` - API vulnerability found (if any)
3. `zap-api-fuzzing.png` - Fuzzing configuration/results

## Part 5: Specific Vulnerability Tests

### Test for XSS in Articles

1. **Create Article with XSS Payload**
   - Login to app
   - Create new article with:
   - Title: `<script>alert('XSS')</script>`
   - Body: `<img src=x onerror=alert('XSS')>`

2. **Check if Executed**
   - View the article
   - Check browser console
   - Check page source

3. **Document Finding**
   - If script executes: **CRITICAL VULNERABILITY**
   - If escaped: **PROTECTED**

### Test for XSS in Comments

1. **Add Comment with XSS Payload**
   - Comment: `<svg onload=alert('XSS')>`

2. **Verify Protection**

### Test for IDOR (Insecure Direct Object References)

1. **Create Article as User 1**
2. **Note the article slug**
3. **Login as User 2 (or use different token)**
4. **Try to DELETE/UPDATE User 1's article**

```bash
DELETE /api/articles/user1-article-slug
Authorization: Token <user2_token>
```

Expected: Should fail with 403 Forbidden

### Test for CSRF

1. **Check if API requires CSRF tokens**
2. **Try to make state-changing requests without CSRF token**

For JWT authentication, CSRF is less critical but still check.

## Saving Your Work

### Session Management

To save your ZAP session:
```
File > Persist Session
Choose location: assignment_2/zap/conduit-zap-session
```

### Export All Findings

```bash
# HTML Report
Report > Generate HTML Report > zap-complete-report.html

# XML Report  
Report > Generate XML Report > zap-complete-report.xml

# JSON Report
Report > Generate JSON Report > zap-complete-report.json

# CSV Report of Alerts
Right-click Alerts > Export All Alerts to File > zap-alerts.csv
```

## Troubleshooting

### Issue: Can't Access Application Through ZAP

**Solution:**
- Verify applications are running
- Check ZAP proxy settings (localhost:8080)
- Try configuring browser proxy manually

### Issue: Authentication Not Working

**Solution:**
- Verify login credentials
- Check token extraction regex
- Test login manually in Postman first
- Review ZAP's "Authentication" output

### Issue: Active Scan Taking Too Long

**Solution:**
- Reduce scan policy to specific categories
- Lower scan strength from High to Medium
- Reduce thread count
- Focus on specific URLs

### Issue: Too Many False Positives

**Solution:**
- Manually verify each finding
- Mark false positives
- Adjust scan policy to reduce noise

## Next Steps

After completing all ZAP scans:

1. Analyze all findings
2. Categorize by OWASP Top 10
3. Prioritize fixes
4. Implement security improvements
5. Re-run scans to verify fixes

## Documentation Files to Create

Based on ZAP findings, create:
- `zap-passive-scan-analysis.md`
- `zap-active-scan-analysis.md`
- `zap-api-security-analysis.md`
- `zap-fixes-applied.md`
- `final-security-assessment.md`

---

**Important Notes:**
- Only scan applications you own or have permission to test
- Active scanning can stress the application
- Some scans may create test data in the database
- Take regular screenshots for your report
- Document all findings thoroughly

## Reference Commands

### CLI-Based Scanning (Alternative)

```bash
# Baseline scan
docker run -t zaproxy/zap-stable zap-baseline.py \
  -t http://localhost:4100 \
  -r zap-baseline-report.html

# Full scan  
docker run -t zaproxy/zap-stable zap-full-scan.py \
  -t http://localhost:4100 \
  -r zap-full-report.html

# API scan
docker run -t zaproxy/zap-stable zap-api-scan.py \
  -t http://localhost:8080/api \
  -f openapi \
  -r zap-api-report.html
```
