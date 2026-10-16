#!/usr/bin/env bash
set -euo pipefail

readonly target_url="${GLASS_FIREWALL_TARGET_URL:-https://glass-firewall-2026-lab.testing-app-astro.workers.dev/}"
readonly runtime_dir="${HOME}/.cache/glassfirewall-codespaces-runtime"
readonly profile_root="${runtime_dir}/chrome-profiles"
readonly pid_file="${runtime_dir}/chrome.pid"
readonly log_file="${runtime_dir}/chrome.log"
readonly next_steps_script="/workspaces/glassfirewall2026-workshop/.devcontainer/codespaces/print-next-steps.sh"

mkdir -p "${profile_root}"
export DISPLAY="${DISPLAY:-:1}"

printf '\n[WAIT] Preparing the private desktop and visible workshop Chrome...\n'

for _ in $(seq 1 60); do
  if xdpyinfo -display "${DISPLAY}" >/dev/null 2>&1; then
    break
  fi
  sleep 1
done

if ! xdpyinfo -display "${DISPLAY}" >/dev/null 2>&1; then
  printf 'The private desktop display %s did not become ready within 60 seconds.\n' "${DISPLAY}" >&2
  exit 1
fi

if curl -fsS --max-time 2 http://127.0.0.1:9222/json/version >/dev/null 2>&1; then
  printf '[READY] Workshop Chrome is already available on the container-only DevTools endpoint.\n'
  bash "${next_steps_script}"
  exit 0
fi

if [[ -s "${pid_file}" ]]; then
  existing_pid="$(cat "${pid_file}")"
  if kill -0 "${existing_pid}" 2>/dev/null && \
      tr '\0' ' ' <"/proc/${existing_pid}/cmdline" 2>/dev/null | grep -q -- '--remote-debugging-port=9222'; then
    chrome_pid="${existing_pid}"
  else
    rm -f "${pid_file}"
  fi
fi

if [[ -z "${chrome_pid:-}" ]]; then
  # A Codespace stop kills Chrome without closing its profile cleanly. A fresh,
  # disposable profile avoids a confusing "Restore pages?" prompt after resume.
  profile_dir="$(mktemp -d "${profile_root}/session.XXXXXX")"

  nohup google-chrome \
    --no-sandbox \
    --remote-debugging-address=127.0.0.1 \
    --remote-debugging-port=9222 \
    --user-data-dir="${profile_dir}" \
    --no-first-run \
    --no-default-browser-check \
    --disable-background-networking \
    --disable-component-update \
    --new-window "${target_url}" \
    >"${log_file}" 2>&1 &

  chrome_pid=$!
  printf '%s\n' "${chrome_pid}" >"${pid_file}"
fi

for _ in $(seq 1 60); do
  if curl -fsS --max-time 2 http://127.0.0.1:9222/json/version >/dev/null 2>&1; then
    printf '[READY] Workshop Chrome is visible on the private desktop.\n'
    bash "${next_steps_script}"
    exit 0
  fi
  if ! kill -0 "${chrome_pid}" 2>/dev/null; then
    printf 'Chrome exited before its DevTools endpoint became ready. See %s.\n' "${log_file}" >&2
    exit 1
  fi
  sleep 1
done

printf 'Chrome did not become ready within 60 seconds. See %s.\n' "${log_file}" >&2
exit 1
