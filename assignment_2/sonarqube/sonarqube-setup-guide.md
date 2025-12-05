# SonarQube Cloud Analysis Setup and Results

## Overview

This document provides instructions for setting up SonarQube Cloud analysis for both the backend (Go) and frontend (React) applications, along with analysis results.

## Setup Instructions

### Prerequisites
- GitHub account with access to the repository
- SonarQube Cloud account (free tier available)

### Step 1: Create SonarQube Cloud Account

1. Visit [https://sonarcloud.io/](https://sonarcloud.io/)
2. Click "Sign up" or "Log in with GitHub"
3. Authorize SonarQube Cloud to access your GitHub account
4. Create or select your organization

### Step 2: Import GitHub Repository

1. Click "+ " button in the top right
2. Select "Analyze new project"
3. Choose "GitHub" as the source
4. Select your repository: `AS2025_SWE302_assignments`
5. Click "Set Up"

### Step 3: Configure Analysis

#### Option A: Automatic Analysis (Recommended for first scan)
1. SonarQube Cloud can automatically analyze supported languages
2. Click "With SonarQube Cloud Automatic Analysis"
3. Wait for the initial analysis to complete

#### Option B: Manual CI/CD Integration
1. Select "With GitHub Actions" or another CI method
2. Follow the provided setup instructions
3. Add the SonarQube token to GitHub secrets

### Step 4: Backend Analysis (Go)

For Go projects, you may need to use manual scanner:

```bash
# Install SonarQube Scanner
brew install sonar-scanner

# Navigate to backend directory
cd golang-gin-realworld-example-app

# Create sonar-project.properties
cat > sonar-project.properties << EOF
sonar.projectKey=your-project-key
sonar.organization=your-organization
sonar.sources=.
sonar.exclusions=**/vendor/**,**/node_modules/**
sonar.host.url=https://sonarcloud.io
sonar.language=go
EOF

# Run analysis
sonar-scanner -Dsonar.login=your-token
```

### Step 5: Frontend Analysis (React)

For React/JavaScript projects:

```bash
# Navigate to frontend directory
cd react-redux-realworld-example-app

# Create sonar-project.properties
cat > sonar-project.properties << EOF
sonar.projectKey=your-project-key
sonar.organization=your-organization
sonar.sources=src
sonar.exclusions=**/node_modules/**,**/*.test.js,**/*.spec.js,**/build/**
sonar.javascript.lcov.reportPaths=coverage/lcov.info
sonar.host.url=https://sonarcloud.io
EOF

# Run analysis
sonar-scanner -Dsonar.login=your-token
```

## Screenshots Required

Please take the following screenshots for your report:

### 1. SonarQube Dashboard
- [ ] Overall project dashboard showing quality gate status
- [ ] Security rating
- [ ] Reliability rating
- [ ] Maintainability rating
- [ ] Code coverage (if available)

**Screenshot Location:** Save as `assignment_2/screenshots/sonarqube-dashboard.png`

### 2. Issues Overview
- [ ] List of all issues (Bugs, Vulnerabilities, Code Smells)
- [ ] Severity breakdown
- [ ] Type distribution

**Screenshot Location:** Save as `assignment_2/screenshots/sonarqube-issues.png`

### 3. Security Hotspots
- [ ] Security hotspots page
- [ ] Reviewed vs. to review hotspots
- [ ] OWASP category breakdown

**Screenshot Location:** Save as `assignment_2/screenshots/sonarqube-security-hotspots.png`

### 4. Code Coverage
- [ ] Overall code coverage percentage
- [ ] Coverage by file/directory
- [ ] Uncovered lines

**Screenshot Location:** Save as `assignment_2/screenshots/sonarqube-coverage.png`

### 5. Code Duplication
- [ ] Duplicated blocks
- [ ] Duplicated lines percentage
- [ ] Duplicated files

**Screenshot Location:** Save as `assignment_2/screenshots/sonarqube-duplications.png`

## Expected Analysis Results

Based on the Snyk scans showing zero vulnerabilities, we expect SonarQube to show:

### Backend (Go) Expected Results:
- **Quality Gate:** Likely to PASS
- **Security Rating:** A or B
- **Reliability Rating:** A or B
- **Maintainability Rating:** A or B
- **Code Smells:** Some expected (formatting, complexity)
- **Bugs:** Minimal or none
- **Vulnerabilities:** Minimal or none (consistent with Snyk)
- **Security Hotspots:** Some for review
- **Duplications:** Low percentage
- **Coverage:** Depends on test coverage

### Frontend (React) Expected Results:
- **Quality Gate:** Likely to PASS
- **Security Rating:** A or B
- **Reliability Rating:** A or B
- **Maintainability Rating:** A or B
- **Code Smells:** Some expected (React patterns, console.log, etc.)
- **Bugs:** Minimal
- **Vulnerabilities:** Minimal or none
- **Security Hotspots:** XSS-related areas
- **Duplications:** Low to moderate
- **Coverage:** Depends on test coverage

## Manual Analysis Template

Once you've run the SonarQube analysis, fill in the following information:

### Backend Analysis Results

**Quality Gate Status:** [PASS/FAIL]

**Ratings:**
- Security: [A/B/C/D/E]
- Reliability: [A/B/C/D/E]
- Maintainability: [A/B/C/D/E]

**Issues Count:**
- Bugs: [count]
- Vulnerabilities: [count]
- Code Smells: [count]
- Security Hotspots: [count]

**Code Metrics:**
- Lines of Code: [count]
- Duplications: [percentage]
- Coverage: [percentage]
- Technical Debt: [time estimate]

### Frontend Analysis Results

**Quality Gate Status:** [PASS/FAIL]

**Ratings:**
- Security: [A/B/C/D/E]
- Reliability: [A/B/C/D/E]
- Maintainability: [A/B/C/D/E]

**Issues Count:**
- Bugs: [count]
- Vulnerabilities: [count]
- Code Smells: [count]
- Security Hotspots: [count]

**Code Metrics:**
- Lines of Code: [count]
- Duplications: [percentage]
- Coverage: [percentage]
- Technical Debt: [time estimate]

## Common SonarQube Findings

### Go Backend Common Issues:
1. **Cognitive Complexity:** Functions with high complexity
2. **Error Handling:** Unchecked errors
3. **Code Duplication:** Repeated code blocks
4. **Unused Variables:** Declared but not used
5. **Security Hotspots:** SQL injection points, authentication

### React Frontend Common Issues:
1. **Console Statements:** console.log left in code
2. **Component Complexity:** Large components
3. **Missing PropTypes:** No type checking
4. **Duplicated Code:** Similar components
5. **Security Hotspots:** dangerouslySetInnerHTML usage

## Troubleshooting

### Issue: Analysis Fails
**Solution:** 
- Check project configuration
- Verify token is valid
- Ensure all required properties are set

### Issue: No Code Coverage
**Solution:**
- Run tests with coverage: `go test -coverprofile=coverage.out ./...`
- For React: `npm test -- --coverage`
- Configure coverage report paths in sonar-project.properties

### Issue: Quality Gate Fails
**Solution:**
- Review failed conditions
- Address critical issues first
- Update quality gate conditions if needed

## Next Steps After Analysis

1. **Review Dashboard:** Examine overall quality metrics
2. **Prioritize Issues:** Focus on security vulnerabilities first
3. **Fix Critical Issues:** Address bugs and vulnerabilities
4. **Refactor Code Smells:** Improve code quality gradually
5. **Review Security Hotspots:** Verify each is properly handled
6. **Re-run Analysis:** Verify improvements after fixes

## Integration with CI/CD

### GitHub Actions Example

Create `.github/workflows/sonarqube.yml`:

```yaml
name: SonarQube Analysis
on:
  push:
    branches:
      - main
  pull_request:
    types: [opened, synchronize, reopened]

jobs:
  sonarqube:
    name: SonarQube Scan
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
        with:
          fetch-depth: 0
      
      - name: SonarQube Scan
        uses: SonarSource/sonarqube-scan-action@master
        env:
          SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}
          SONAR_HOST_URL: https://sonarcloud.io
```

## Resources

- [SonarQube Cloud Documentation](https://docs.sonarqube.org/latest/analysis/scan/sonarscanner/)
- [Go Analysis](https://docs.sonarqube.org/latest/analysis/languages/go/)
- [JavaScript Analysis](https://docs.sonarqube.org/latest/analysis/languages/javascript/)
- [Quality Gates](https://docs.sonarqube.org/latest/user-guide/quality-gates/)

## Checklist

Before completing this task, ensure:

- [ ] SonarQube Cloud account created
- [ ] Repository connected to SonarQube Cloud
- [ ] Backend analysis completed
- [ ] Frontend analysis completed
- [ ] Screenshots taken and saved
- [ ] Analysis results documented
- [ ] Security hotspots reviewed
- [ ] Issues prioritized

---

**Note:** This is a setup guide. After completing the SonarQube Cloud setup and running the analysis, create the detailed analysis documents:
- `sonarqube-backend-analysis.md`
- `sonarqube-frontend-analysis.md`
- `security-hotspots-review.md`
- `sonarqube-improvements.md`
