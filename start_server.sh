#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SERVER_DIR="$SCRIPT_DIR/services"

echo "================================"
echo "  Notes App Server"
echo "================================"
echo ""
echo "Starting Dart Frog dev server on port 8080..."
echo ""

cd "$SERVER_DIR"
dart_frog dev
