#!/bin/bash

# Assignment 2 - Quick Testing Script
# This script helps verify security headers and provides screenshots guidance

echo "=================================="
echo "Assignment 2 - Testing Helper"
echo "=================================="
echo ""

# Check if applications are running
echo "📋 Checking Application Status..."
echo ""

# Check backend
if lsof -ti:8080 > /dev/null; then
    BACKEND_PID=$(lsof -ti:8080)
    echo "✅ Backend is running (PID: $BACKEND_PID) on http://localhost:8080"
else
    echo "❌ Backend is NOT running"
    echo "   Start it with: cd golang-gin-realworld-example-app && go run hello.go"
fi

# Check frontend
if lsof -ti:4100 > /dev/null; then
    FRONTEND_PID=$(lsof -ti:4100)
    echo "✅ Frontend is running (PID: $FRONTEND_PID) on http://localhost:4100"
else
    echo "❌ Frontend is NOT running"
    echo "   Start it with: cd react-redux-realworld-example-app && npm start"
fi

echo ""
echo "=================================="
echo "Testing Security Headers"
echo "=================================="
echo ""

# Note: Backend needs restart to load new headers
echo "⚠️  NOTE: If you just implemented security headers, restart the backend:"
echo "   1. Kill current backend: kill $BACKEND_PID"
echo "   2. Restart: cd golang-gin-realworld-example-app && go run hello.go"
echo ""

echo "Testing /api/articles endpoint..."
echo ""
curl -I http://localhost:8080/api/articles 2>&1 | head -20

echo ""
echo "=================================="
echo "Next Steps for You"
echo "=================================="
echo ""
echo "1. 🌐 Open SonarQube Cloud: https://sonarcloud.io/"
echo "   - Sign up with GitHub"
echo "   - Import your repository"
echo "   - Wait for analysis (5-10 min)"
echo "   - Take screenshots of dashboard"
echo ""
echo "2. 🔍 Install OWASP ZAP: https://www.zaproxy.org/download/"
echo "   - Download for macOS"
echo "   - Install and launch"
echo "   - Run Automated Scan on http://localhost:4100"
echo "   - Take screenshots of results"
echo ""
echo "3. 📸 Screenshot Locations:"
echo "   Save all screenshots to: assignment_2/screenshots/"
echo ""
echo "4. 📝 Documentation:"
echo "   - Read: assignment_2/COMPLETION_GUIDE.md (full instructions)"
echo "   - Fill in templates with your findings"
echo ""
echo "=================================="
echo "Quick Reference"
echo "=================================="
echo ""
echo "URLs to visit:"
echo "  - Frontend: http://localhost:4100"
echo "  - Backend API: http://localhost:8080/api"
echo "  - SonarQube: https://sonarcloud.io"
echo "  - ZAP Download: https://www.zaproxy.org/download/"
echo ""
echo "Test credentials (create these in the app):"
echo "  - Email: securitytest@example.com"
echo "  - Password: SecurePass123!"
echo ""
echo "Time estimates:"
echo "  - SonarQube setup: 30-45 min"
echo "  - ZAP passive scan: 20-30 min"
echo "  - ZAP active scan: 60-90 min"
echo "  - Documentation: 45-60 min"
echo "  - Total: 4-6 hours"
echo ""
echo "Good luck! 🚀"
echo ""
