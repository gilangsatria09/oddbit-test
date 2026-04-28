#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "================================"
echo "  Notes App Initial Setup"
echo "================================"

echo ""
echo "[1/2] Running build_runner for services..."
echo ""
cd "$SCRIPT_DIR/services"
dart run build_runner build --delete-conflicting-outputs --force-jit

echo ""
echo "[2/2] Running build_runner for notes_app..."
echo ""
cd "$SCRIPT_DIR/notes_app"
dart run build_runner build --delete-conflicting-outputs --force-jit

echo ""
echo "Setup complete."
