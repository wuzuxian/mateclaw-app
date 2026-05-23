#!/bin/sh
set -eu

ROOT="$(git rev-parse --show-toplevel)"
cd "$ROOT"

chmod +x .githooks/pre-commit
git config core.hooksPath .githooks

echo "Git hooks installed: core.hooksPath=.githooks"
