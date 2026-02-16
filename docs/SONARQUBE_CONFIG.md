# SonarQube Configuration Guide

## Initial Setup Steps

### 1. Access SonarQube
- URL: http://localhost:9000
- Default credentials: admin/admin
- Change password on first login

### 2. Create Project

1. Click "Create Project" button
2. Select "Manually"
3. Enter:
   - Project key: `safezone-ecommerce`
   - Display name: `SafeZone E-Commerce Microservices`
4. Click "Set Up"

### 3. Generate Token

1. Select "With GitHub Actions"
2. Click "Generate a token"
3. Copy the token
4. Add to GitHub Secrets as `SONAR_TOKEN`

### 4. Configure Quality Gate

Navigate to Quality Gates → Create:

**Quality Gate: SafeZone Standards**

Conditions on New Code:
- Coverage: > 80%
- Duplicated Lines: < 3%
- Maintainability Rating: A
- Reliability Rating: A
- Security Rating: A
- Security Hotspots Reviewed: 100%

Set as default for the project.

### 5. Configure Permissions

Administration → Security → Users:
- Create service account for CI/CD
- Grant "Execute Analysis" permission

### 6. Set Up Notifications

My Account → Notifications:
- Enable: Quality gate status changes
- Enable: New issues
- Enable: Security hotspots

## Project Configuration

The `sonar-project.properties` file contains:

```properties
sonar.projectKey=safezone-ecommerce
sonar.projectName=SafeZone E-Commerce Microservices
sonar.projectVersion=1.0
sonar.sources=services
sonar.sourceEncoding=UTF-8
sonar.exclusions=**/node_modules/**,**/venv/**,**/__pycache__/**
```

## Quality Profiles

Use default profiles or customize:
- Python: Sonar way
- JavaScript: Sonar way
- Java: Sonar way

## Webhooks (Production)

For production deployment:

1. Administration → Configuration → Webhooks
2. Create webhook:
   - Name: GitHub Integration
   - URL: Your GitHub webhook URL
   - Secret: Configure in GitHub

## Security Configuration

1. Force authentication: ✓
2. Disable anonymous access: ✓
3. Enable HTTPS (production): ✓
4. Regular token rotation: Every 90 days

## Maintenance

- Regular updates: Check for SonarQube updates monthly
- Database backup: Weekly
- Review quality gate: Quarterly
- Clean old analyses: Keep last 30 days
