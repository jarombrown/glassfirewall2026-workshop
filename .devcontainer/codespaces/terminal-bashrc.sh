#!/usr/bin/env bash

# Preserve the image's normal interactive-shell behavior, including VS Code's
# shell integration, before adding the workshop status board.
if [[ -f "${HOME}/.bashrc" ]]; then
  # shellcheck disable=SC1090
  source "${HOME}/.bashrc"
fi

if [[ "${CODESPACES:-}" == "true" ]]; then
  readonly workshop_dir="/workspaces/glassfirewall2026-workshop/.devcontainer/codespaces"

  if curl -fsS --max-time 2 http://127.0.0.1:9222/json/version >/dev/null 2>&1; then
    bash "${workshop_dir}/print-next-steps.sh"
  else
    cat <<'EOF'

+-----------------------------------------------------------------+
| GLASS FIREWALL CODESPACE - WAIT                                 |
| The visible workshop Chrome is still starting.                  |
| Keep this tab open. This normally takes less than one minute.    |
+-----------------------------------------------------------------+

The setup command will print a READY box below. If it does not,
wait for the port counter to appear and then run:
bash .devcontainer/codespaces/check-readiness.sh

EOF
  fi
fi
