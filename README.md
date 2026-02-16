# SafeZone E-Commerce Microservices with SonarQube

Complete SonarQube integration for code quality and security monitoring.

## Prerequisites

- Docker and Docker Compose
- Git
- GitHub account

## 1. SonarQube Setup with Docker

### Start SonarQube

```bash

\
```

Or manually:

```bash
docker-compose up -d
```

### Access SonarQube

1. Open http://localhost:9000
2. Login with default credentials: `admin/admin`
3. Change password when prompted

## 2. SonarQube Configuration

### Create Project

1. Click "Create Project" → "Manually"
2. Project key: `safezone-ecommerce`
3. Display name: `SafeZone E-Commerce Microservices`
4. Click "Set Up"

### Generate Token

1. Choose "With GitHub Actions"
2. Generate token and copy it
3. Save as `SONAR_TOKEN` in GitHub Secrets

### Configure Quality Gate

1. Go to Quality Gates
2. Set conditions:
   - Coverage > 80%
   - Duplications < 3%
   - Maintainability Rating = A
   - Reliability Rating = A
   - Security Rating = A

## 3. GitHub Integration

### Option A: SonarCloud (Recommended for GitHub)

1. Go to https://sonarcloud.io
2. Sign in with GitHub
3. Analyze new project → Select your repository
4. Generate token: My Account → Security → Generate Token
5. Add to GitHub Secrets:
   - `SONAR_TOKEN`: Your SonarCloud token
6. Update `sonar-project.properties` with your organization

### Option B: Local SonarQube Only

1. Disable GitHub workflows (see `docs/GITHUB_ACTIONS_FIX.md`)
2. Use local analysis only:
   ```bash
   docker run --rm \
     -e SONAR_HOST_URL="http://host.docker.internal:9000" \
     -e SONAR_TOKEN="your-token" \
     -v "$(pwd):/usr/src" \
     sonarsource/sonar-scanner-cli
   ```

### Webhook Configuration (Optional for local)

For production SonarQube:
1. GitHub Settings → Webhooks → Add webhook
2. Payload URL: `http://your-sonarqube-url:9000/github-webhook/`
3. Content type: `application/json`
4. Events: Pull requests, Pushes

## 4. Code Analysis

### Automated Analysis

Analysis runs automatically on:
- Push to `main` or `develop` branches
- Pull request creation/update

### Manual Analysis

```bash
docker run --rm \
  -e SONAR_HOST_URL="http://localhost:9000" \
  -e SONAR_TOKEN="your-token" \
  -v "$(pwd):/usr/src" \
  sonarsource/sonar-scanner-cli
```

### Pipeline Behavior

- ✅ Quality Gate Pass: Pipeline continues
- ❌ Quality Gate Fail: Pipeline fails, blocks merge

## 5. Continuous Monitoring

SonarQube monitors:
- Code smells and technical debt
- Security vulnerabilities
- Code coverage
- Code duplications
- Complexity metrics

## 6. Code Review Process

### Pull Request Workflow

1. Developer creates PR
2. GitHub Actions triggers SonarQube analysis
3. Quality gate check runs
4. Results posted to PR
5. Reviewers check:
   - SonarQube quality gate status
   - Code quality metrics
   - Security issues
6. Approval required before merge

### Review Checklist

- [ ] No blocker/critical issues
- [ ] Quality gate passed
- [ ] Code coverage maintained
- [ ] Security vulnerabilities addressed

## Bonus Features

### Email Notifications

1. SonarQube → Administration → Configuration → General Settings → Email
2. Configure SMTP settings
3. Enable notifications per project

### Slack Notifications

Add to `.github/workflows/sonarqube-analysis.yml`:

```yaml
- name: Slack Notification
  uses: 8398a7/action-slack@v3
  with:
    status: ${{ job.status }}
    text: 'SonarQube analysis completed'
    webhook_url: ${{ secrets.SLACK_WEBHOOK }}
  if: always()
```

### IDE Integration

#### VS Code

1. Install "SonarLint" extension
2. Configure connected mode:
   - Command Palette → "SonarLint: Add SonarQube Connection"
   - URL: `http://localhost:9000`
   - Token: Your SonarQube token

#### IntelliJ IDEA

1. Install "SonarLint" plugin
2. Settings → Tools → SonarLint → Add connection
3. Configure server URL and token

## Project Structure

```
safe-zone/
├── .github/
│   ├── workflows/
│   │   ├── sonarqube-analysis.yml
│   │   └── code-review.yml
│   └── PULL_REQUEST_TEMPLATE.md
├── services/
│   ├── product-service/
│   │   ├── app.py
│   │   └── requirements.txt
│   └── order-service/
│       ├── app.py
│       └── requirements.txt
├── docker-compose.yml
├── sonar-project.properties
└── README.md
```

## Testing Checklist

- [x] SonarQube accessible at http://localhost:9000
- [x] Project configured in SonarQube
- [x] GitHub Actions workflows created
- [x] Quality gate configured
- [x] PR template with review checklist
- [x] Pipeline fails on quality issues
- [x] Code review process documented

## Troubleshooting

### SonarQube not starting

```bash
docker-compose logs sonarqube
docker-compose restart sonarqube
```

### Analysis failing

Check:
- `sonar-project.properties` configuration
- GitHub secrets are set correctly
- Token has proper permissions

### Quality gate always failing

Review and adjust quality gate conditions in SonarQube UI

## Resources

- [SonarQube Documentation](https://docs.sonarqube.org/)
- [GitHub Actions Documentation](https://docs.github.com/actions)
- [SonarLint IDE Integration](https://www.sonarlint.org/)
