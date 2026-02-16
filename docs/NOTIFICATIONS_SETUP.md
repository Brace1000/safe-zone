# Notifications Setup (Bonus)

## Email Notifications

### Configure SMTP in SonarQube

1. Administration → Configuration → General Settings → Email
2. Configure:
   - SMTP host: `smtp.gmail.com`
   - SMTP port: `587`
   - SMTP username: `your-email@gmail.com`
   - SMTP password: `your-app-password`
   - From address: `sonarqube@yourcompany.com`

### Enable User Notifications

1. My Account → Notifications
2. Enable:
   - Quality gate status changes
   - New issues assigned to me
   - Issues resolved as false positive or won't fix
   - New quality gate threshold reached

## Slack Notifications

### Setup Slack Webhook

1. Go to Slack API: https://api.slack.com/apps
2. Create New App → From scratch
3. Add Incoming Webhooks
4. Activate and create webhook URL
5. Copy webhook URL

### Add to GitHub Actions

Update `.github/workflows/sonarqube-analysis.yml`:

```yaml
- name: Slack Notification
  uses: 8398a7/action-slack@v3
  with:
    status: ${{ job.status }}
    text: 'SonarQube Analysis: ${{ job.status }}'
    webhook_url: ${{ secrets.SLACK_WEBHOOK }}
    fields: repo,message,commit,author
  if: always()
```

### Add GitHub Secret

Repository Settings → Secrets → Add:
- Name: `SLACK_WEBHOOK`
- Value: Your Slack webhook URL

## Notification Examples

### Slack Message Format

```
✅ SonarQube Analysis: Success
Repository: safezone-ecommerce
Branch: main
Quality Gate: Passed
Coverage: 85%
Issues: 0 critical, 2 minor
```

### Email Template

Subject: [SonarQube] Quality Gate Status - SafeZone

Body:
- Project: SafeZone E-Commerce
- Quality Gate: PASSED/FAILED
- New Issues: X
- Coverage: X%
- View Report: [Link]
