#!/usr/bin/env bash
# Usage: bash scripts/update-openapi.sh [proxy-base-url]
# Snapshots a running proxy's /openapi.json into static/openapi.json; run from the repo root.
# The daily .github/workflows/update-openapi.yml job calls this script to keep the snapshot in sync.
set -euo pipefail
curl -sf "${1:-http://localhost:4000}/openapi.json" -o static/openapi.json
# The proxy links its own relative /ui/model_hub_table, which 404s on docs.litellm.ai
sed -i 's#](/ui/model_hub_table)#](https://models.litellm.ai/)#g' static/openapi.json
