# OWASP ZAP Passive Scan Analysis

## Scan Information

- **Scan Date:** [To be filled]
- **Target URL:** http://localhost:4100
- **Scan Type:** Passive
- **Scan Duration:** [duration]
- **URLs Discovered:** [count]

## Executive Summary

The passive scan observes HTTP traffic without actively attacking the application. It identifies security issues based on HTTP responses, headers, and content.

**Overall Risk Assessment:** [Low/Medium/High]

## Alerts Summary

### By Risk Level

| Risk Level | Count | Percentage |
|------------|-------|------------|
| High | [count] | [%] |
| Medium | [count] | [%] |
| Low | [count] | [%] |
| Informational | [count] | [%] |
| **Total** | **[count]** | **100%** |

### By Confidence

| Confidence | Count |
|------------|-------|
| High Confidence | [count] |
| Medium Confidence | [count] |
| Low Confidence | [count] |

## High Priority Findings

### 1. Missing Anti-Clickjacking Header (X-Frame-Options)

**Risk Level:** Medium  
**Confidence:** Medium  
**CWE:** CWE-1021  
**OWASP:** A5:2017-Broken Access Control

**Description:**  
The X-Frame-Options header is not set, allowing the page to be loaded in a frame or iframe. This could enable clickjacking attacks.

**URLs Affected:**
- http://localhost:4100/
- http://localhost:4100/login
- http://localhost:4100/register
- [list all affected URLs]

**Attack Scenario:**  
An attacker could embed the application in a malicious website using an iframe and trick users into clicking on invisible buttons or links.

**Evidence:**
```http
HTTP/1.1 200 OK
Content-Type: text/html
[Notice: No X-Frame-Options header]
```

**Recommendation:**  
Add the X-Frame-Options header to all responses:
```
X-Frame-Options: DENY
```
Or if framing from same origin is needed:
```
X-Frame-Options: SAMEORIGIN
```

**Fix Priority:** High  
**Estimated Effort:** 30 minutes

---

### 2. Content Security Policy (CSP) Header Not Set

**Risk Level:** Medium  
**Confidence:** Medium  
**CWE:** CWE-693  
**OWASP:** A6:2017-Security Misconfiguration

**Description:**  
The Content Security Policy (CSP) header is not set, reducing protection against XSS attacks.

**URLs Affected:**
- [all HTML pages]

**Attack Scenario:**  
Without CSP, if an XSS vulnerability exists, attackers can inject and execute arbitrary JavaScript.

**Evidence:**
```http
HTTP/1.1 200 OK
Content-Type: text/html
[Notice: No Content-Security-Policy header]
```

**Recommendation:**  
Implement a strict Content Security Policy:
```
Content-Security-Policy: default-src 'self'; script-src 'self'; style-src 'self' 'unsafe-inline'; img-src 'self' data: https:; font-src 'self'; connect-src 'self' http://localhost:8080;
```

**Fix Priority:** High  
**Estimated Effort:** 2-3 hours (requires testing)

---

### 3. X-Content-Type-Options Header Missing

**Risk Level:** Low  
**Confidence:** Medium  
**CWE:** CWE-16  

**Description:**  
The X-Content-Type-Options header is not set, allowing browsers to MIME-sniff responses.

**URLs Affected:**
- [all responses]

**Attack Scenario:**  
Browser could interpret files as a different MIME type than intended, potentially executing malicious content.

**Recommendation:**  
```
X-Content-Type-Options: nosniff
```

**Fix Priority:** Medium  
**Estimated Effort:** 15 minutes

---

### 4. Cookie Without Secure Flag

**Risk Level:** Medium  
**Confidence:** High  
**CWE:** CWE-614  
**OWASP:** A3:2017-Sensitive Data Exposure

**Description:**  
Cookies are set without the Secure flag, allowing transmission over unencrypted HTTP.

**Cookies Affected:**
- [cookie name 1]
- [cookie name 2]

**Evidence:**
```http
Set-Cookie: session_id=abc123; Path=/; HttpOnly
[Notice: No Secure flag]
```

**Attack Scenario:**  
If the site is accessed over HTTP, cookies could be intercepted by an attacker on the network.

**Recommendation:**  
Add Secure flag to all cookies:
```
Set-Cookie: session_id=abc123; Path=/; HttpOnly; Secure; SameSite=Strict
```

**Fix Priority:** High  
**Estimated Effort:** 30 minutes

---

### 5. Cookie Without SameSite Attribute

**Risk Level:** Low  
**Confidence:** Medium  
**CWE:** CWE-1275  
**OWASP:** A8:2017-Cross-Site Request Forgery

**Description:**  
Cookies don't have the SameSite attribute, making them vulnerable to CSRF attacks.

**Recommendation:**  
```
Set-Cookie: session_id=abc123; Path=/; HttpOnly; Secure; SameSite=Strict
```

**Fix Priority:** Medium  
**Estimated Effort:** 15 minutes

---

## Medium Priority Findings

### 6. Server Leaks Information via "X-Powered-By" Header

**Risk Level:** Low  
**Confidence:** Medium  
**CWE:** CWE-200  

**Description:**  
Server reveals technology stack via headers.

**Evidence:**
```http
X-Powered-By: Express
```

**Recommendation:**  
Remove or obscure X-Powered-By header.

---

### 7. Incomplete or No Cache-control Header Set

**Risk Level:** Low  
**Confidence:** Medium  

**Description:**  
Cache-control headers not optimally configured.

**URLs Affected:**
- Sensitive pages (login, profile, etc.)

**Recommendation:**  
For sensitive pages:
```
Cache-Control: no-store, no-cache, must-revalidate
Pragma: no-cache
```

---

### 8. Timestamp Disclosure - Unix

**Risk Level:** Informational  
**Confidence:** Low  

**Description:**  
Unix timestamps found in responses, may aid reconnaissance.

**Impact:**  
Low - Informational only

---

## Low/Informational Findings

### 9. Cross-Domain JavaScript Source File Inclusion

**Risk Level:** Low  
**Instances:** [count]

**Description:**  
JavaScript loaded from external domains.

**Analysis:**  
Check if these are legitimate (CDNs, analytics, etc.)

---

### 10. Information Disclosure - Debug Error Messages

**Risk Level:** Low  

**Description:**  
Error messages may reveal internal information.

**Recommendation:**  
Use generic error messages in production.

---

## OWASP Top 10 Mapping

### A3:2017-Sensitive Data Exposure
- Cookie Without Secure Flag
- Incomplete Cache-control Headers

### A5:2017-Broken Access Control
- Missing X-Frame-Options

### A6:2017-Security Misconfiguration
- Missing CSP
- Missing X-Content-Type-Options
- Server Information Disclosure

### A8:2017-Cross-Site Request Forgery
- Cookie Without SameSite Attribute

## Summary Statistics

### Scan Coverage
- **Pages Scanned:** [count]
- **Total Requests:** [count]
- **Scan Duration:** [time]

### Issues by Category
```
Security Headers:        [count]
Cookie Security:         [count]
Information Disclosure:  [count]
Other:                   [count]
```

## Positive Findings

What's working well:
- [List security measures already in place]
- [Example: HTTPS appears to be available]
- [Example: No obvious information leakage]

## Risk Assessment

**Current Security Posture:** [Assessment]

**Primary Concerns:**
1. Missing security headers leave application vulnerable to clickjacking and XSS
2. Cookie security needs improvement
3. Information disclosure through headers

**Overall Risk Level:** MEDIUM

The passive scan revealed primarily **security configuration issues** rather than direct vulnerabilities. Most findings are related to missing security headers, which are relatively easy to fix.

## Recommendations Priority Matrix

| Priority | Finding | Effort | Impact |
|----------|---------|--------|--------|
| P1 | Add security headers | Low | High |
| P2 | Fix cookie security | Low | High |
| P3 | Remove server headers | Low | Medium |
| P4 | Implement CSP | Medium | High |

## Next Steps

1. **Implement Security Headers** (Priority: High)
   - Add X-Frame-Options, X-Content-Type-Options, CSP
   - Fix cookie security attributes
   
2. **Run Active Scan** (Next Phase)
   - Active scanning will probe for actual vulnerabilities
   
3. **Test Fixes**
   - Re-run passive scan after implementing fixes
   - Verify headers are correctly set

4. **Documentation**
   - Document all security headers implemented
   - Create security header implementation guide

## Evidence Files

- **HTML Report:** `zap-passive-report.html`
- **JSON Report:** `zap-passive-report.json`
- **Screenshots:** `assignment_2/screenshots/zap-passive-*.png`

## Comparison with SAST Results

| Finding | Passive Scan | Snyk | SonarQube |
|---------|--------------|------|-----------|
| Missing Headers | Yes | N/A | Possible |
| Cookie Security | Yes | N/A | N/A |
| Info Disclosure | Yes | No | Possible |

**Analysis:**  
Passive scan findings complement SAST tools by focusing on HTTP-level security rather than code-level vulnerabilities.

## Conclusion

The passive scan identified **[count] issues**, primarily related to **security configuration**. No critical code vulnerabilities were found in this phase, which is consistent with the Snyk SAST results.

**Key Takeaways:**
1. Application needs improved security headers
2. Cookie security requires attention
3. No severe vulnerabilities in passive analysis
4. Active scanning needed for deeper testing

The findings are typical for modern web applications and can be addressed through configuration changes rather than code changes.

---

**Scanned by:** OWASP ZAP  
**Scan Type:** Passive  
**Date:** [Date]  
**Analyst:** [Your name]

## Screenshots Reference

Include the following screenshots in `assignment_2/screenshots/`:
- [ ] `zap-passive-alerts-summary.png`
- [ ] `zap-passive-high-risk.png`
- [ ] `zap-passive-sites-tree.png`
- [ ] `zap-passive-missing-headers.png`
