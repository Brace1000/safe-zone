# SafeZone E-Commerce Microservices with SonarQube

E-commerce microservices project with automated code quality monitoring using SonarQube and SonarCloud.

## Features

- ✅ Local SonarQube setup with Docker
- ✅ SonarCloud integration for GitHub
- ✅ Automated code analysis on push/PR
- ✅ Security vulnerability detection
- ✅ Quality gate enforcement
- ✅ Python microservices (Product & Order)

## Quick Start

### 1. Start Local SonarQube

```bash
sudo systemctl start docker
sudo docker compose up -d
```

Access: http://localhost:9000 (admin/admin)

### 2. Run Code Analysis

```bash
# Get token from SonarQube UI: My Account → Security → Generate Token
docker run --rm \
  -e SONAR_HOST_URL="http://host.docker.internal:9000" \
  -e SONAR_TOKEN="your-token" \
  -v "$(pwd):/usr/src" \
  sonarsource/sonar-scanner-cli
```

### 3. Test Microservices

```bash
./test-services.sh
```

## GitHub Integration

**For automated CI/CD with SonarCloud:**

1. Go to https://sonarcloud.io and import repository
2. Generate token: Profile → My Account → Security
3. Add GitHub Secret: `SONAR_TOKEN`
4. Update `sonar-project.properties` with your username:
```properties
sonar.projectKey=YOUR_USERNAME_safe-zone
sonar.organization=YOUR_USERNAME
```
5. Push code to trigger analysis

## Testing

```bash
# Test SonarQube setup
./test-sonarqube.sh

# Test microservices
./test-services.sh

# Manual health check
curl http://localhost:5001/health  # Product service
curl http://localhost:5002/health  # Order service
```

## Project Structure

```
safe-zone/
├── .github/workflows/          # CI/CD workflows
├── services/
│   ├── product-service/        # Product API
│   └── order-service/          # Order API
├── docs/SETUP_GUIDE.md         # Detailed setup guide
├── docker-compose.yml          # SonarQube container
├── sonar-project.properties    # Analysis config
└── test-*.sh                   # Test scripts
```

## Documentation

- **Setup Guide**: `docs/SETUP_GUIDE.md` - Complete setup and testing instructions
- **Workflows**: `.github/workflows/` - CI/CD configuration

## Success Criteria

✅ SonarQube accessible at http://localhost:9000
✅ Code analysis completes successfully
✅ Microservices respond to health checks
✅ GitHub Actions workflows pass
✅ SonarCloud dashboard shows results

## Troubleshooting

**SonarQube not accessible:**
```bash
sudo docker compose up -d
sudo docker logs sonarqube
```

**GitHub Actions failing:**
- Verify `SONAR_TOKEN` secret exists
- Check `sonar-project.properties` configuration
- Review Actions logs

## Resources

- [SonarQube Documentation](https://docs.sonarqube.org/)
- [SonarCloud](https://sonarcloud.io)
- [GitHub Actions](https://docs.github.com/actions)
