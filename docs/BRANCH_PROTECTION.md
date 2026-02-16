# Branch Protection Configuration

Configure these settings in GitHub repository Settings → Branches → Add rule:

## Protected Branch: `main`

### Required Settings:

1. **Require pull request reviews before merging**
   - Required approving reviews: 1
   - Dismiss stale pull request approvals when new commits are pushed: ✓

2. **Require status checks to pass before merging**
   - Require branches to be up to date before merging: ✓
   - Status checks that are required:
     - `SonarQube Code Analysis`
     - `Code Quality Review`

3. **Require conversation resolution before merging**: ✓

4. **Do not allow bypassing the above settings**: ✓

This ensures:
- All code goes through SonarQube analysis
- Quality gate must pass
- At least one approval required
- All conversations resolved
