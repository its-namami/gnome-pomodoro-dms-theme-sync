#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

for cmd in dms gsettings python3 systemctl; do
    if ! command -v "${cmd}" >/dev/null 2>&1; then
        echo "Missing dependency: ${cmd}" >&2
        exit 1
    fi
done

install -Dm755 "${SCRIPT_DIR}/bin/pomodoro-dms-theme-sync" "${HOME}/.local/bin/pomodoro-dms-theme-sync"
install -Dm644 "${SCRIPT_DIR}/systemd/pomodoro-dms-theme-sync.service" "${HOME}/.config/systemd/user/pomodoro-dms-theme-sync.service"

systemctl --user daemon-reload
systemctl --user enable --now pomodoro-dms-theme-sync.service

echo "Installed and started pomodoro-dms-theme-sync.service"
