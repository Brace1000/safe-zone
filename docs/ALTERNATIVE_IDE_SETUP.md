# Alternative IDE Integration (Without SonarLint)

If SonarLint extension is not available, use these alternatives:

## Option 1: VS Code Tasks

Create `.vscode/tasks.json`:

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "SonarQube Scan",
      "type": "shell",
      "command": "docker run --rm -e SONAR_HOST_URL=http://localhost:9000 -e SONAR_TOKEN=${input:sonarToken} -v ${workspaceFolder}:/usr/src sonarsource/sonar-scanner-cli",
      "problemMatcher": []
    }
  ],
  "inputs": [
    {
      "id": "sonarToken",
      "type": "promptString",
      "description": "Enter SonarQube token"
    }
  ]
}
```

Run: Terminal → Run Task → SonarQube Scan

## Option 2: Manual CLI Analysis

```bash
docker run --rm \
  -e SONAR_HOST_URL="http://localhost:9000" \
  -e SONAR_TOKEN="your-token" \
  -v "$(pwd):/usr/src" \
  sonarsource/sonar-scanner-cli
```

## Option 3: Pre-commit Hook

Create `.git/hooks/pre-commit`:

```bash
#!/bin/bash
echo "Running SonarQube analysis..."
docker run --rm \
  -e SONAR_HOST_URL="http://localhost:9000" \
  -e SONAR_TOKEN="your-token" \
  -v "$(pwd):/usr/src" \
  sonarsource/sonar-scanner-cli
```

Make executable: `chmod +x .git/hooks/pre-commit`

## Option 4: Python Linters

Install alternative linters:

```bash
pip install pylint flake8 bandit
```

Run locally:
```bash
pylint services/
flake8 services/
bandit -r services/
```

## Option 5: Web Dashboard

Simply check SonarQube web interface at http://localhost:9000 after each commit.
