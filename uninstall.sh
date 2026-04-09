#!/usr/bin/env bash
set -euo pipefail

if ! command -v systemctl >/dev/null 2>&1; then
    echo "Missing dependency: systemctl" >&2
    exit 1
fi

readonly UNIT="pomodoro-dms-theme-sync.service"
readonly SERVICE_PATH="${HOME}/.config/systemd/user/${UNIT}"
readonly SCRIPT_PATH="${HOME}/.local/bin/pomodoro-dms-theme-sync"

if [[ -f "${SERVICE_PATH}" ]]; then
    systemctl --user disable --now "${UNIT}"
fi

rm -f "${SERVICE_PATH}" "${SCRIPT_PATH}"
systemctl --user daemon-reload

echo "Uninstalled ${UNIT}"
