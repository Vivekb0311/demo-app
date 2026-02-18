# Run the demo pipeline and deploy to K8s

## 1. Create the GitHub repo

- Go to https://github.com/new
- Repository name: **demo-app**
- Owner: **Vivekb0311**
- Public, no README (we already have code)
- Create repository

## 2. Push the code (commit is already done)

From the **demo-app** directory:

```bash
cd /Users/ent-00409/Documents/jenkin-x/demo-app
git push -u origin main
```

(Use a personal access token as password if prompted.)

## 3. Import the repo into Jenkins X

So Lighthouse runs the pipeline on this repo:

```bash
jx project import --batch-mode --git-url https://github.com/Vivekb0311/demo-app.git
```

Or interactively:

```bash
jx project import
```
Then choose the **demo-app** repo when prompted.

## 4. Trigger the release pipeline

Either:

**Option A – push a tag (triggers release):**
```bash
git tag v0.0.1
git push origin v0.0.1
```

**Option B – push a commit to main (if your JX is set to run release on main):**
```bash
echo "" >> README.md
git add README.md && git commit -m "trigger release" && git push origin main
```

## 5. Watch pipeline and deployment

```bash
# Pipeline pods
jx pipeline pods

# Or list PipelineRuns
kubectl get pipelineruns -n jx

# After pipeline succeeds, app is promoted to staging (or dev)
kubectl get pods -n jx-staging
kubectl get svc -n jx-staging
```

## Summary

- **Committed:** demo app (Maven + Java 17), Dockerfile, Helm chart, and `.lighthouse/jenkins-x/release.yaml`.
- **You do:** create **Vivekb0311/demo-app** on GitHub, then `git push -u origin main`, then `jx project import`, then trigger (tag or push).
- **Result:** Pipeline builds jar → builds image with Kaniko → updates chart → promotes and deploys to K8s (jx-staging / jx-production).
