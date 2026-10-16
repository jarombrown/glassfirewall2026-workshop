#!/usr/bin/env bash
set -euo pipefail

cat <<'EOF'

+------------------------------------------------------------------+
| GLASS FIREWALL CODESPACE                                         |
+------------------------------------------------------------------+
| INSTALLED  The fixed workshop software is in the container.      |
| WAIT       The visible Chrome starts after setup finishes.       |
+------------------------------------------------------------------+
EOF

printf 'Node:                 %s\n' "$(node --version)"
printf 'Google Chrome:        %s\n' "$(google-chrome --version)"
printf 'Chrome DevTools MCP:  %s\n' "$(chrome-devtools-mcp --version)"
printf '\nKeep this tab open. The next READY message will show what to do.\n'
