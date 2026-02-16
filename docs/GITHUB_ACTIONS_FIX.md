# GitHub Actions Fix - Use SonarCloud

Your GitHub Actions is failing because localhost:9000 isn't accessible from GitHub servers.

## Option 1: Use SonarCloud (Recommended for GitHub)

### Setup SonarCloud

1. Go to https://sonarcloud.io
2. Sign in with GitHub
3. Click "+" → "Analyze new project"
4. Select your repository: `safe-zone`
5. Click "Set Up"

### Get Token

1. Click your profile picture (top right corner)
2. Click "My Account"
3. Click "Security" tab
4. Under "Generate Tokens" section:
   - Enter name: `github-actions`
   - Click "Generate"
5. Copy the token (it will only show once!)

**Screenshot guide:**
- Profile icon → My Account → Security tab → "Generate Tokens" section at bottom

### Update GitHub Secrets

Repository Settings → Secrets → Update:
- `SONAR_TOKEN`: Your SonarCloud token
- `SONAR_HOST_URL`: `https://sonarcloud.io`

### Update sonar-project.properties

```properties
sonar.projectKey=your-github-username_safe-zone
sonar.organization=your-github-username
sonar.projectName=SafeZone E-Commerce Microservices
sonar.projectVersion=1.0
sonar.sources=services
sonar.sourceEncoding=UTF-8
sonar.exclusions=**/node_modules/**,**/venv/**,**/__pycache__/**
```

### Update Workflow

Replace `.github/workflows/sonarqube-analysis.yml` with:

```yaml
name: SonarCloud Analysis

on:
  push:
    branches:
      - main
      - develop
  pull_request:
    types: [opened, synchronize, reopened]

jobs:
  sonarcloud:
    name: SonarCloud Code Analysis
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v3
        with:
          fetch-depth: 0
      
      - name: SonarCloud Scan
        uses: SonarSource/sonarcloud-github-action@master
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}
```

## Option 2: Disable GitHub Actions (Local Only)

If you only want local SonarQube testing:

### Delete or Disable Workflows

```bash
# Rename to disable
mv .github/workflows/sonarqube-analysis.yml .github/workflows/sonarqube-analysis.yml.disabled
mv .github/workflows/code-review.yml .github/workflows/code-review.yml.disabled
```

### Test Locally Only

```bash
# Run analysis locally
docker run --rm \
  -e SONAR_HOST_URL="http://host.docker.internal:9000" \
  -e SONAR_TOKEN="your-local-token" \
  -v "$(pwd):/usr/src" \
  sonarsource/sonar-scanner-cli
```

## Option 3: Expose Local SonarQube (Advanced)

Use ngrok to expose localhost:

```bash
# Install ngrok
snap install ngrok

# Expose SonarQube
ngrok http 9000
```

Copy the ngrok URL (e.g., `https://abc123.ngrok.io`) and set as `SONAR_HOST_URL` in GitHub Secrets.

**Note:** Free ngrok URLs change on restart.

## Recommended Approach

For this project demonstration:
- **Local development**: Use local SonarQube (localhost:9000)
- **GitHub CI/CD**: Use SonarCloud (free for public repos)

This gives you both local testing and automated GitHub integration.
