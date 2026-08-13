#!/bin/bash
set -euo pipefail

TARGET_DIRS=("mods" "resourcepacks" "shaderpacks")
TOTAL=0

for dir in "${TARGET_DIRS[@]}"; do
  if [ ! -d "$dir" ]; then
    echo "[skip] $dir: directory not found"
    continue
  fi

  while IFS= read -r -d '' file; do
    echo "  $file"

    # side → 'both'（匹配 side = '' / 'client' / 'server' / 'both'）
    sed -i "s/^side = '.*'/side = 'both'/" "$file"

    TOTAL=$((TOTAL + 1))
  done < <(find "$dir" -name "*.pw.toml" -type f -print0)
done

echo ""
echo "Done. Processed $TOTAL file(s)."
