#!/bin/bash

set -e

REMOTE=origin
BRANCH=main

for f in part_*; do
  # Check if file already committed
  if git ls-files --error-unmatch "$f" >/dev/null 2>&1; then
    echo "[SKIP] $f already committed"
    continue
  fi

  echo "[ADD] $f"
  git add "$f"
  git commit -m "add $f"

  # Retry loop for push
  until git push $REMOTE $BRANCH; do
    echo "[RETRY] push failed for $f, retrying in 5s..."
    sleep 5
  done

  echo "[DONE] $f uploaded"
done

echo "All parts processed."
