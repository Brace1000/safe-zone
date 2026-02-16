# SonarCloud Token Generation - Step by Step

## Visual Guide to Get Your Token

### Step 1: Access SonarCloud
- Go to: https://sonarcloud.io
- Sign in with your GitHub account

### Step 2: Navigate to Security Settings
```
Top Right Corner → Click your profile picture/avatar
                 ↓
              My Account
                 ↓
              Security tab
```

### Step 3: Generate Token
Look for the section titled **"Generate Tokens"** (usually at the bottom of the Security page)

You'll see:
```
┌─────────────────────────────────────┐
│ Generate Tokens                      │
├─────────────────────────────────────┤
│ Name: [________________]             │
│                                      │
│ Type: ○ User Token (default)        │
│       ○ Project Analysis Token       │
│                                      │
│ Expires in: [30 days ▼]             │
│                                      │
│ [Generate] button                    │
└─────────────────────────────────────┘
```

**Fill in:**
1. Name: `github-actions` (or any name you prefer)
2. Type: Keep "User Token" selected
3. Expires in: Choose duration (30 days, 90 days, or No expiration)
4. Click **"Generate"** button

### Step 4: Copy Token
After clicking Generate, you'll see:
```
┌─────────────────────────────────────┐
│ ✓ Token generated successfully      │
│                                      │
│ sqp_1234567890abcdef...              │
│                                      │
│ [Copy] button                        │
│                                      │
│ ⚠️ Make sure to copy your token now. │
│    You won't be able to see it again!│
└─────────────────────────────────────┘
```

**IMPORTANT:** Click the **Copy** button immediately! The token will only be shown once.

### Step 5: Add to GitHub Secrets
1. Go to your GitHub repository
2. Click **Settings** tab
3. Left sidebar → **Secrets and variables** → **Actions**
4. Click **"New repository secret"**
5. Name: `SONAR_TOKEN`
6. Value: Paste the token you copied
7. Click **"Add secret"**

## Alternative: Direct URL
After logging into SonarCloud, go directly to:
```
https://sonarcloud.io/account/security
```

## Troubleshooting

**Can't find "My Account"?**
- Look for your profile picture/avatar in the top-right corner
- Click it to see dropdown menu
- "My Account" should be first option

**Can't find "Security" tab?**
- After clicking "My Account", you'll see tabs at the top
- Tabs are: Profile | Security | Notifications | Organizations
- Click "Security"

**Can't find "Generate Tokens"?**
- Scroll down on the Security page
- It's usually at the bottom after "Revoke Tokens" section

**Token not working?**
- Make sure you copied the entire token (starts with `sqp_`)
- Check there are no extra spaces
- Verify it's added to GitHub Secrets correctly
- Token name in GitHub must be exactly: `SONAR_TOKEN`
