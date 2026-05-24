#!/usr/bin/env bash
set -euo pipefail

RULE_FILE="/etc/udev/rules.d/51-android.rules"
TARGET_USER="${SUDO_USER:-${USER}}"
VENDOR_ID="${1:-}"

log() {
  printf '[adb-permission-fix] %s\n' "$*"
}

fail() {
  printf '[adb-permission-fix] ERROR: %s\n' "$*" >&2
  exit 1
}

require_command() {
  command -v "$1" >/dev/null 2>&1 || fail "missing required command: $1"
}

run_sudo() {
  if [ "$(id -u)" -eq 0 ]; then
    "$@"
  else
    sudo "$@"
  fi
}

find_adb() {
  if command -v adb >/dev/null 2>&1; then
    command -v adb
    return
  fi

  if [ -x "$HOME/Android/Sdk/platform-tools/adb" ]; then
    printf '%s\n' "$HOME/Android/Sdk/platform-tools/adb"
    return
  fi

  fail "adb not found. Install Android platform-tools or add adb to PATH."
}

detect_vendor_id() {
  if [ -n "$VENDOR_ID" ]; then
    printf '%s\n' "$VENDOR_ID"
    return
  fi

  local line
  line="$(lsusb | awk 'BEGIN {IGNORECASE=1} /ADB|Android|Xiaomi|Google|Huawei|Samsung|OnePlus|OPPO|vivo|Motorola|Sony|HTC/ {print; exit}')"

  if [ -z "$line" ]; then
    fail "could not auto-detect Android USB vendor id. Re-run with vendor id, for example: bash scripts/fix_adb_usb_permissions.sh 2717"
  fi

  printf '%s\n' "$line" | sed -n 's/.*ID \([0-9a-fA-F]\{4\}\):.*/\1/p'
}

validate_vendor_id() {
  printf '%s' "$1" | grep -Eq '^[0-9a-fA-F]{4}$' || fail "invalid vendor id: $1"
}

main() {
  require_command getent
  require_command grep
  require_command id
  require_command lsusb
  require_command sed
  require_command sudo
  require_command udevadm
  require_command usermod

  local adb_bin
  adb_bin="$(find_adb)"

  local vendor_id
  vendor_id="$(detect_vendor_id)"
  validate_vendor_id "$vendor_id"
  vendor_id="$(printf '%s' "$vendor_id" | tr 'A-F' 'a-f')"

  log "target user: $TARGET_USER"
  log "android usb vendor id: $vendor_id"
  log "adb: $adb_bin"

  if ! getent group plugdev >/dev/null; then
    log "creating plugdev group"
    run_sudo groupadd plugdev
  fi

  if ! id -nG "$TARGET_USER" | grep -qw plugdev; then
    log "adding $TARGET_USER to plugdev"
    run_sudo usermod -aG plugdev "$TARGET_USER"
  else
    log "$TARGET_USER is already in plugdev"
  fi

  local rule
  rule="SUBSYSTEM==\"usb\", ATTR{idVendor}==\"$vendor_id\", MODE=\"0666\", GROUP=\"plugdev\", TAG+=\"uaccess\""

  log "writing $RULE_FILE"
  printf '%s\n' "$rule" | run_sudo tee "$RULE_FILE" >/dev/null

  log "reloading udev rules"
  run_sudo udevadm control --reload-rules
  run_sudo udevadm trigger

  log "restarting adb server"
  "$adb_bin" kill-server >/dev/null 2>&1 || true
  "$adb_bin" start-server

  log "adb devices"
  "$adb_bin" devices -l

  if command -v flutter >/dev/null 2>&1; then
    log "flutter devices"
    flutter devices
  elif [ -x "$HOME/.local/flutter/bin/flutter" ]; then
    log "flutter devices"
    "$HOME/.local/flutter/bin/flutter" devices
  else
    log "flutter not found; skipped flutter devices"
  fi

  log "done. If your current desktop session was started before joining plugdev, log out and log back in."
}

main "$@"
