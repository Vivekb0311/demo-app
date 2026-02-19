#!/usr/bin/env bash
# Stop all demo-app release PipelineRuns in jx namespace (stops the flood of auto-triggered runs).
# Run: ./scripts/stop-all-release-runs.sh   or   bash scripts/stop-all-release-runs.sh
set -e
echo "Deleting all demo-app release PipelineRuns in namespace jx..."
kubectl get pipelineruns -n jx --no-headers -o name 2>/dev/null | grep -E "demo-app.*release" | xargs -I {} kubectl delete {} -n jx --ignore-not-found 2>/dev/null || true
echo "Done. Check: kubectl get pipelineruns -n jx"
