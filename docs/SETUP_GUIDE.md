# SafeZone Setup Guide

Complete guide for setting up and testing the SafeZone e-commerce microservices with SonarQube/SonarCloud integration.

## Prerequisites

- Docker and Docker Compose
- Git
- GitHub account
- Python 3.8+

## Quick Start

### 1. Local SonarQube Setup

```bash
# Start SonarQube
sudo systemctl start docker
sudo docker compose up -d

# Wait 1-2 minutes, then access
# URL: http://localhost:9000
# Login: admin/admin (change password on first login)
```

### 2. Configure Local SonarQube

1. Create project: Project key = `safezone-ecommerce`
2. Generate token: My Account → Security → Generate Token
3. Run analysis:
```bash
docker run --rm \
  -e SONAR_HOST_URL="http://host.docker.internal:9000" \
  -e SONAR_TOKEN="your-token" \
  -v "$(pwd):/usr/src" \
  sonarsource/sonar-scanner-cli
```

### 3. GitHub Integration (SonarCloud)

**Setup SonarCloud:**
1. Go to https://sonarcloud.io
2. Sign in with GitHub
3. Import your repository
4. Generate token: Profile → My Account → Security → Generate Token

**Configure GitHub:**
1. Add GitHub Secret: `SONAR_TOKEN` (your SonarCloud token)
2. Update `sonar-project.properties`:
```properties
sonar.projectKey=YOUR_USERNAME_safe-zone
sonar.organization=YOUR_USERNAME
```

**Push to trigger analysis:**
```bash
git add .
git commit -m "ci: configure SonarCloud"
git push origin main
```

## Testing

### Automated Tests

```bash
# Test SonarQube setup
./test-sonarqube.sh

# Test microservices
./test-services.sh
```

### Manual Testing

**1. Check SonarQube:**
```bash
curl http://localhost:9000/api/system/status
# Expected: {"status":"UP"}
```

**2. Test Product Service:**
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

**3. Test Order Service:**
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

**4. Verify GitHub Actions:**
- Go to repository → Actions tab
- Check "SonarCloud Analysis" workflow status
- Should show ✅ green checkmark

**5. View SonarCloud Results:**
- Go to https://sonarcloud.io
- Click your project
- Review code quality metrics

## Success Criteria

✅ **Project is working when:**
- Local SonarQube accessible at http://localhost:9000
- Code analysis completes without errors
- Microservices respond to health checks
- GitHub Actions workflows pass
- SonarCloud dashboard shows analysis results

## Troubleshooting

**SonarQube not starting:**
```bash
sudo systemctl start docker
sudo docker compose up -d
sudo docker logs sonarqube
```

**GitHub Actions failing:**
- Verify `SONAR_TOKEN` secret is set
- Check `sonar-project.properties` has correct organization
- Review Actions logs for specific errors

**Microservices not responding:**
- Check port availability (5001, 5002)
- Verify Python dependencies installed
- Check for error messages in terminal

## Project Structure

```
safe-zone/
├── .github/workflows/          # CI/CD workflows
├── services/
│   ├── product-service/        # Product microservice
│   └── order-service/          # Order microservice
├── docs/                       # Documentation
├── docker-compose.yml          # SonarQube container
├── sonar-project.properties    # SonarQube config
├── test-sonarqube.sh          # Test script
└── README.md                   # This file
```

## Key Features Demonstrated

✅ SonarQube setup with Docker
✅ GitHub Actions CI/CD integration
✅ Automated code quality analysis
✅ Security vulnerability detection
✅ Pull request quality gates
✅ Microservices architecture
✅ Code review process
