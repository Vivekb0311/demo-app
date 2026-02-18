# demo-app

Jenkins X demo: Maven app + Helm chart. Pipeline builds, images, and deploys to Kubernetes.

## Run the demo (commit, push, deploy)

1. **Create a new repo** (e.g. `Vivekb0311/demo-app` on GitHub) and add it as remote:
   ```bash
   cd demo-app
   git init
   git remote add origin https://github.com/Vivekb0311/demo-app.git
   ```

2. **Commit and push** (use main or master per your JX config):
   ```bash
   git add .
   git commit -m "chore: initial demo app, chart and pipeline"
   git branch -M main
   git push -u origin main
   ```

3. **Import repo into Jenkins X** (so Lighthouse runs the pipeline):
   ```bash
   jx project import
   ```
   Or add the repo to your GitOps source config in `jx3-gitops` and commit.

4. **Trigger release** (pipeline runs on push to main; or create a version tag):
   ```bash
   git tag v0.0.1
   git push origin v0.0.1
   ```
   Or push a commit to main; the release pipeline will run and deploy to dev.

5. **Watch pipeline and deploy**:
   ```bash
   jx pipeline pods
   kubectl get pods -n jx-staging   # or jx-production after promote
   ```

## Contents

- `src/` – Java 17 Maven app
- `Dockerfile` – container image
- `charts/demo-app/` – Helm chart for K8s deploy
- `.lighthouse/jenkins-x/release.yaml` – Tekton release pipeline
