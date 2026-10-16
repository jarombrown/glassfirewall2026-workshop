#!/usr/bin/env bash
set -euo pipefail

cat <<'EOF'

+-----------------------------------------------------------------+
| GLASS FIREWALL CODESPACE - READY                                |
| 1  PORTS > private port 6080 > Open in Browser                  |
| 2  noVNC > Connect; use that Chrome, not laptop Chrome          |
| 3  Copilot Chat > Agent > Permissions: Allow all                |
| 4  Send the prompt below                                        |
+-----------------------------------------------------------------+

Use the chrome-devtools-codespaces-shared tools to inspect the
already-open Chrome tab. Report its page title and URL. Do not edit files.

Ready = the response includes a successful list_pages tool call.
Use this disposable session only; do not enter personal credentials.
Checks: bash .devcontainer/codespaces/check-readiness.sh

EOF
