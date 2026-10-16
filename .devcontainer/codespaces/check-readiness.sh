#!/usr/bin/env bash
set -uo pipefail

passes=0
failures=0

pass() {
  printf 'PASS  %s\n' "$1"
  passes=$((passes + 1))
}

fail() {
  printf 'FAIL  %s\n' "$1"
  failures=$((failures + 1))
}

if [[ "${CODESPACES:-}" == "true" ]]; then pass 'Running in GitHub Codespaces'; else fail 'CODESPACES=true is not set'; fi

node_version="$(node --version 2>/dev/null || true)"
if [[ "${node_version}" == v24.* ]]; then pass "Node ${node_version}"; else fail "Expected Node 24, found ${node_version:-missing}"; fi

chrome_version="$(google-chrome --version 2>/dev/null || true)"
if [[ "${chrome_version}" == 'Google Chrome 155.0.8059.79 '* || "${chrome_version}" == 'Google Chrome 155.0.8059.79' ]]; then
  pass "${chrome_version}"
else
  fail "Expected Google Chrome 155.0.8059.79, found ${chrome_version:-missing}"
fi

mcp_version="$(chrome-devtools-mcp --version 2>/dev/null || true)"
if [[ "${mcp_version}" == '1.10.1' ]]; then pass "Chrome DevTools MCP ${mcp_version}"; else fail "Expected Chrome DevTools MCP 1.10.1, found ${mcp_version:-missing}"; fi

if curl -fsS --max-time 3 http://127.0.0.1:6080/ >/dev/null 2>&1; then pass 'Private noVNC desktop responds on port 6080'; else fail 'noVNC is not responding on port 6080'; fi
if curl -fsS --max-time 3 http://127.0.0.1:9222/json/version >/dev/null 2>&1; then pass 'Shared Chrome DevTools endpoint responds inside the container'; else fail 'Chrome DevTools endpoint is not responding on port 9222'; fi

if ss -ltn 2>/dev/null | awk '$4 == "0.0.0.0:9222" || $4 == "[::]:9222" {found=1} END {exit !found}'; then
  fail 'Chrome debugging is exposed beyond the container loopback interface'
elif ss -ltn 2>/dev/null | awk '$4 == "127.0.0.1:9222" {found=1} END {exit !found}'; then
  pass 'Chrome debugging listens only on 127.0.0.1:9222'
else
  fail 'Chrome debugging is not confirmed as loopback-only'
fi

if curl -fsS --max-time 10 https://glass-firewall-2026-lab.testing-app-astro.workers.dev/api/health | grep -q '"status":"ready"'; then
  pass 'Hosted workshop lab health check'
else
  fail 'Hosted workshop lab health check'
fi

if curl -fsS --max-time 3 http://127.0.0.1:9222/json/list | grep -q 'glass-firewall-2026-lab.testing-app-astro.workers.dev'; then
  pass 'Shared Chrome has the hosted workshop lab open'
else
  fail 'Hosted workshop lab is not open in shared Chrome'
fi

printf '\nAutomated result: %s passed, %s failed.\n' "${passes}" "${failures}"
printf 'MANUAL CHECK REQUIRED  Sign in to Copilot in VS Code for the Web and confirm Agent mode.\n'
printf 'MANUAL CHECK REQUIRED  Select Allow all for this disposable workshop session.\n'
printf 'MANUAL CHECK REQUIRED  Send the first inspection prompt and confirm an MCP tool call succeeds.\n'
printf 'MANUAL CHECK REQUIRED  Navigate in noVNC and confirm the agent can retrieve that request.\n'
printf 'MANUAL CHECK REQUIRED  Ask the agent to navigate and confirm the same noVNC Chrome changes.\n'

if (( failures > 0 )); then exit 1; fi
