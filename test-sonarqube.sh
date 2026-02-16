#!/bin/bash

echo "🧪 SafeZone SonarQube Test Suite"
echo "================================="
echo ""

PASS=0
FAIL=0

# Test 1: Docker running
echo "Test 1: Checking Docker service..."
if sudo systemctl is-active --quiet docker; then
    echo "✅ Docker is running"
    ((PASS++))
else
    echo "❌ Docker is not running"
    ((FAIL++))
fi

# Test 2: SonarQube container
echo "Test 2: Checking SonarQube container..."
if sudo docker ps | grep -q sonarqube; then
    echo "✅ SonarQube container is running"
    ((PASS++))
else
    echo "❌ SonarQube container is not running"
    ((FAIL++))
fi

# Test 3: SonarQube API
echo "Test 3: Checking SonarQube API..."
RESPONSE=$(curl -s http://localhost:9000/api/system/status)
if echo "$RESPONSE" | grep -q "UP"; then
    echo "✅ SonarQube API is responding"
    ((PASS++))
else
    echo "❌ SonarQube API is not responding"
    ((FAIL++))
fi

# Test 4: Project files exist
echo "Test 4: Checking project files..."
if [ -f "sonar-project.properties" ] && [ -f "docker-compose.yml" ]; then
    echo "✅ Configuration files exist"
    ((PASS++))
else
    echo "❌ Configuration files missing"
    ((FAIL++))
fi

# Test 5: GitHub workflows
echo "Test 5: Checking GitHub workflows..."
if [ -f ".github/workflows/sonarqube-analysis.yml" ] && [ -f ".github/workflows/code-review.yml" ]; then
    echo "✅ GitHub workflows configured"
    ((PASS++))
else
    echo "❌ GitHub workflows missing"
    ((FAIL++))
fi

# Test 6: Microservices exist
echo "Test 6: Checking microservices..."
if [ -f "services/product-service/app.py" ] && [ -f "services/order-service/app.py" ]; then
    echo "✅ Microservices code exists"
    ((PASS++))
else
    echo "❌ Microservices code missing"
    ((FAIL++))
fi

# Test 7: Documentation
echo "Test 7: Checking documentation..."
if [ -f "README.md" ] && [ -f "docs/SONARQUBE_CONFIG.md" ]; then
    echo "✅ Documentation exists"
    ((PASS++))
else
    echo "❌ Documentation missing"
    ((FAIL++))
fi

echo ""
echo "================================="
echo "Test Results: $PASS passed, $FAIL failed"
echo "================================="

if [ $FAIL -eq 0 ]; then
    echo "✅ All tests passed! Project is ready."
    exit 0
else
    echo "❌ Some tests failed. Check the output above."
    exit 1
fi
