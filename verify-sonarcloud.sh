#!/bin/bash

echo "🔍 SonarCloud Integration Verification"
echo "======================================="
echo ""

# Check 1: sonar-project.properties
echo "✓ Step 1: Checking sonar-project.properties..."
if grep -q "sonar.organization" sonar-project.properties; then
    echo "  ✅ Organization configured"
else
    echo "  ⚠️  Add your organization to sonar-project.properties"
fi

# Check 2: GitHub Secrets
echo ""
echo "✓ Step 2: Verify GitHub Secrets"
echo "  Go to: https://github.com/YOUR_USERNAME/safe-zone/settings/secrets/actions"
echo "  Required secrets:"
echo "    - SONAR_TOKEN (should be set)"
echo "    - GITHUB_TOKEN (automatically available)"

# Check 3: Workflow file
echo ""
echo "✓ Step 3: Checking workflow file..."
if [ -f ".github/workflows/sonarcloud-analysis.yml" ]; then
    echo "  ✅ SonarCloud workflow exists"
else
    echo "  ⚠️  Create .github/workflows/sonarcloud-analysis.yml"
fi

echo ""
echo "======================================="
echo "Next Steps:"
echo "1. Commit and push changes"
echo "2. Check GitHub Actions tab"
echo "3. View results on SonarCloud"
echo "======================================="
