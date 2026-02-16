# IDE Integration (Bonus)

## SonarLint for VS Code

### Installation

1. Open VS Code
2. Go to Extensions (Ctrl+Shift+X)
3. Search "SonarLint" (Publisher: SonarSource)
4. If not found, search "SonarSource.sonarlint-vscode"
5. Or install directly: https://marketplace.visualstudio.com/items?itemName=SonarSource.sonarlint-vscode
6. Click Install

### Connected Mode Setup

1. Open Command Palette (Ctrl+Shift+P)
2. Type "SonarLint: Add SonarQube Connection"
3. Enter:
   - Connection name: `SafeZone Local`
   - SonarQube URL: `http://localhost:9000`
4. Generate token in SonarQube:
   - My Account → Security → Generate Token
5. Paste token in VS Code
6. Select project: `safezone-ecommerce`

### Features

- Real-time code analysis
- Inline issue highlighting
- Quick fixes suggestions
- Security hotspot detection

## SonarLint for IntelliJ IDEA

### Installation

1. File → Settings → Plugins
2. Search "SonarLint"
3. Install and restart

### Configuration

1. File → Settings → Tools → SonarLint
2. Click "+" to add connection
3. Select "SonarQube"
4. Enter:
   - Configuration name: `SafeZone`
   - Server URL: `http://localhost:9000`
   - Token: Generate from SonarQube
5. Bind project to `safezone-ecommerce`

### Usage

- Right-click file → Analyze with SonarLint
- View issues in SonarLint panel
- Apply quick fixes

## SonarLint for PyCharm

Same as IntelliJ IDEA setup.

## Benefits

- Catch issues before commit
- Consistent code quality
- Learn best practices
- Reduce CI/CD failures
- Faster feedback loop

## Configuration File

Create `.vscode/settings.json`:

```json
{
  "sonarlint.connectedMode.connections.sonarqube": [
    {
      "serverUrl": "http://localhost:9000",
      "connectionId": "safezone"
    }
  ],
  "sonarlint.connectedMode.project": {
    "projectKey": "safezone-ecommerce"
  }
}
```
