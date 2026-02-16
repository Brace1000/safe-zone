# SafeZone Testing Guide

## Quick Test Checklist

Run these tests to verify everything works:

```bash
# 1. Check Docker is running
sudo docker ps

# 2. Check SonarQube is accessible
curl http://localhost:9000/api/system/status

# 3. Run local code analysis
./test-sonarqube.sh

# 4. Test microservices
./test-services.sh
```

## Detailed Testing Steps

### 1. SonarQube Setup Test

**Check SonarQube is running:**
```bash
sudo docker ps | grep sonarqube
```
Expected: Container named `sonarqube` with status `Up`

**Check web interface:**
- Open: http://localhost:9000
- Login: admin/admin
- Expected: Dashboard loads successfully

**Verify API:**
```bash
curl http://localhost:9000/api/system/status
```
Expected: `{"status":"UP"}`

### 2. Project Configuration Test

**In SonarQube UI:**

1. Create project manually:
   - Project key: `safezone-ecommerce`
   - Display name: `SafeZone E-Commerce Microservices`

2. Generate token:
   - My Account → Security → Generate Token
   - Name: `test-token`
   - Copy token for next step

3. Verify project exists:
   - Projects → Should see `SafeZone E-Commerce Microservices`

### 3. Local Code Analysis Test

**Run manual analysis:**
```bash
docker run --rm \
  -e SONAR_HOST_URL="http://host.docker.internal:9000" \
  -e SONAR_TOKEN="your-token-here" \
  -v "$(pwd):/usr/src" \
  sonarsource/sonar-scanner-cli
```

**Expected output:**
- Analysis starts
- Files scanned
- Results uploaded
- Quality gate status shown

**Verify in UI:**
- Go to http://localhost:9000
- Click on project
- See analysis results with metrics

### 4. Microservices Test

**Test Product Service:**
```bash
cd services/product-service
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python app.py &
curl http://localhost:5001/health
curl http://localhost:5001/products
kill %1
deactivate
cd ../..
```

**Expected:**
- Health endpoint returns: `{"status":"healthy"}`
- Products endpoint returns: JSON array with 2 products

**Test Order Service:**
```bash
cd services/order-service
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python app.py &
curl http://localhost:5002/health
curl http://localhost:5002/orders
kill %1
deactivate
cd ../..
```

**Expected:**
- Health endpoint returns: `{"status":"healthy"}`
- Orders endpoint returns: Empty JSON array `[]`

### 5. GitHub Integration Test

**Prerequisites:**
- GitHub repository created
- Code pushed to GitHub

**Setup GitHub Secrets:**
1. Go to: Settings → Secrets and variables → Actions
2. Add `SONAR_TOKEN`: Your SonarQube token
3. Add `SONAR_HOST_URL`: Your public SonarQube URL (or use ngrok for local)

**Test workflow:**
```bash
git add .
git commit -m "test: trigger sonarqube analysis"
git push origin main
```

**Verify:**
- Go to: Actions tab in GitHub
- See "SonarQube Analysis" workflow running
- Workflow should complete successfully
- Check SonarQube UI for new analysis

### 6. Pull Request Test

**Create test PR:**
```bash
git checkout -b test-pr
echo "# Test" >> test.md
git add test.md
git commit -m "test: pr workflow"
git push origin test-pr
```

**Create PR on GitHub:**
- Go to repository → Pull requests → New
- Create PR from `test-pr` to `main`

**Expected:**
- GitHub Actions runs automatically
- "Code Review Process" workflow executes
- SonarQube analysis runs
- Quality gate check completes
- Comment appears on PR

### 7. Quality Gate Test

**Add intentional code issue:**
```python
# services/product-service/bad_code.py
def bad_function():
    password = "hardcoded123"  # Security issue
    x = 1
    y = 2
    z = 3
    # Unused variables - code smell
    return None
```

**Run analysis:**
```bash
git add services/product-service/bad_code.py
git commit -m "test: quality gate failure"
git push
```

**Expected:**
- Analysis detects security issue
- Quality gate fails
- GitHub Actions workflow fails
- Issues visible in SonarQube UI

### 8. Code Coverage Test

**Add test file:**
```python
# services/product-service/test_app.py
import pytest
from app import app

def test_health():
    client = app.test_client()
    response = client.get('/health')
    assert response.status_code == 200
    assert response.json['status'] == 'healthy'

def test_products():
    client = app.test_client()
    response = client.get('/products')
    assert response.status_code == 200
    assert len(response.json) == 2
```

**Run tests with coverage:**
```bash
cd services/product-service
pytest --cov=app --cov-report=xml
```

**Expected:**
- Tests pass
- Coverage report generated
- SonarQube shows coverage metrics

## Success Criteria

✅ **All tests pass if:**

1. SonarQube accessible at http://localhost:9000
2. Project created and visible in UI
3. Manual analysis completes successfully
4. Microservices respond to health checks
5. GitHub Actions workflows execute
6. Quality gate enforced on PRs
7. Code issues detected and displayed
8. Coverage metrics visible

## Troubleshooting

**SonarQube not accessible:**
```bash
sudo systemctl start docker
sudo docker compose up -d
sudo docker logs sonarqube
```

**Analysis fails:**
- Check `sonar-project.properties` exists
- Verify token is valid
- Ensure project key matches

**GitHub Actions fail:**
- Verify secrets are set correctly
- Check workflow syntax
- Review Actions logs

**Quality gate always fails:**
- Review quality gate conditions
- Check if too strict for initial setup
- Adjust thresholds in SonarQube UI

## Performance Benchmarks

**Expected timings:**
- SonarQube startup: 1-2 minutes
- Code analysis: 30-60 seconds
- GitHub Actions workflow: 2-3 minutes
- Quality gate check: 5-10 seconds

## Next Steps After Testing

1. Configure branch protection rules
2. Set up email/Slack notifications
3. Integrate with IDE (SonarLint)
4. Schedule regular scans
5. Review and fix detected issues
