#!/usr/bin/env sh
set -eu

SOURCE_DIR="${FLOWOPS_SOURCE:-/workspace}"
APP_DIR="${FLOWOPS_APP:-/app}"

if [ ! -d "$SOURCE_DIR" ]; then
  echo "FlowOps source directory not found: $SOURCE_DIR" >&2
  echo "Mount the FlowOps source with FLOWOPS_SOURCE_DIR or copy it into ./flowops-src." >&2
  exit 1
fi

mkdir -p "$APP_DIR" /data/storage/projects /data/storage/config

rsync -a --delete \
  --exclude='.git' \
  --exclude='.pytest_cache' \
  --exclude='.ruff_cache' \
  --exclude='__pycache__' \
  --exclude='*.pyc' \
  --exclude='backup' \
  --exclude='backups' \
  --exclude='.backups' \
  --exclude='node_modules' \
  --exclude='parapruebas' \
  --exclude='templates/backups' \
  --exclude='templates/projects_backup_*' \
  --exclude='static/blockly' \
  --exclude='static/getting-started-codelab' \
  --exclude='static/msg' \
  --exclude='static/templates' \
  --exclude='docs/*.zip' \
  --exclude='*.zip' \
  --exclude='tmp' \
  --exclude='storage' \
  --exclude='*.sqlite3' \
  --exclude='*.sqlite3-shm' \
  --exclude='*.sqlite3-wal' \
  --exclude='*.db' \
  "$SOURCE_DIR"/ "$APP_DIR"/

cd "$APP_DIR"

if [ ! -f /data/blockly_nodes.sqlite3 ]; then
  : > /data/blockly_nodes.sqlite3
fi

rm -f "$APP_DIR/blockly_nodes.sqlite3"
ln -s /data/blockly_nodes.sqlite3 "$APP_DIR/blockly_nodes.sqlite3"

rm -rf "$APP_DIR/storage"
ln -s /data/storage "$APP_DIR/storage"

if [ ! -f /data/storage/config/inventory.yaml ]; then
  cat > /data/storage/config/inventory.yaml <<'EOF'
inventory:
  ssh:
    hosts: {}
    bastions: {}
  ansible:
    groups: {}
    inventories: {}
  oc:
    clusters: {}
EOF
fi

python /lab_migrate.py /data/blockly_nodes.sqlite3

exec "$@"
