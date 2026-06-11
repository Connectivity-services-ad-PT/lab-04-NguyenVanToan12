#!/usr/bin/env bash
set -euo pipefail

npx prism mock contracts/analytics-alert.openapi.yaml --host 0.0.0.0 --port 4010
