#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APP_DIR="$SCRIPT_DIR/notes_app"

echo "================================"
echo "  Notes App Runner"
echo "================================"
echo ""
echo "Select target:"
echo "  1) iOS Simulator    → localhost:8080"
echo "  2) Android Emulator → 10.0.2.2:8080"
echo "  3) Physical Device  → custom IP"
echo ""
printf "Choice [1-3]: "
read -r choice

case "$choice" in
  1) BASE_URL="http://localhost:8080" ;;
  2) BASE_URL="http://10.0.2.2:8080" ;;
  3)
    printf "Device IP address: "
    read -r device_ip
    BASE_URL="http://${device_ip}:8080"
    ;;
  *)
    echo "Invalid choice."
    exit 1
    ;;
esac

echo ""
echo "Fetching devices..."
cd "$APP_DIR"
ALL_DEVICES=$(flutter devices 2>/dev/null)

case "$choice" in
  1) FILTERED=$(echo "$ALL_DEVICES" | grep "•" | grep -i "simulator") ;;
  2) FILTERED=$(echo "$ALL_DEVICES" | grep "•" | grep -i "emulator") ;;
  3) FILTERED=$(echo "$ALL_DEVICES" | grep "•" | grep -iv "simulator" | grep -iv "emulator") ;;
esac

if [[ -z "${FILTERED// }" ]]; then
  echo ""
  echo "No devices found. Make sure your target is running."
  exit 1
fi

declare -a DEVICE_LINES=()
while IFS= read -r line; do
  [[ -z "${line// }" ]] && continue
  DEVICE_LINES+=("$line")
done <<< "$FILTERED"

echo ""
echo "Available devices:"
for idx in "${!DEVICE_LINES[@]}"; do
  echo "  $((idx + 1))) ${DEVICE_LINES[$idx]}"
done
echo ""

if [[ ${#DEVICE_LINES[@]} -eq 1 ]]; then
  echo "Auto-selecting the only available device."
  dev_num=1
else
  printf "Select device [1-${#DEVICE_LINES[@]}]: "
  read -r dev_num
  if ! [[ "$dev_num" =~ ^[0-9]+$ ]] || [ "$dev_num" -lt 1 ] || [ "$dev_num" -gt "${#DEVICE_LINES[@]}" ]; then
    echo "Invalid selection."
    exit 1
  fi
fi

SELECTED="${DEVICE_LINES[$((dev_num - 1))]}"
DEVICE_ID=$(echo "$SELECTED" | awk -F'•' '{print $2}' | xargs)
DEVICE_NAME=$(echo "$SELECTED" | awk -F'•' '{print $1}' | xargs)

echo ""
echo "  Device:   $DEVICE_NAME"
echo "  Base URL: $BASE_URL"
echo ""
echo "Launching..."
echo ""

flutter run -d "$DEVICE_ID" --dart-define=BASE_URL="$BASE_URL"
