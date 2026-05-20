#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

MODEL_FILE="backend/artifacts/lgbm_proc_days.txt"
DATA_CSV="${KTL_DATA_CSV:-data/통합_시험접수_현황.csv}"

if [[ ! -f "$MODEL_FILE" ]]; then
  if [[ ! -f "$DATA_CSV" ]]; then
    echo "[FATAL] Missing model artifact: $MODEL_FILE"
    echo "        Commit backend/artifacts, or provide KTL_DATA_CSV and train before deploy."
    exit 1
  fi
  echo "[start] training model from $DATA_CSV..."
  python backend/train.py
fi

echo "[start] seeding demo applications (idempotent)..."
python -m backend.seed || true

PORT="${PORT:-10000}"
echo "[start] starting uvicorn on 0.0.0.0:${PORT}"
exec python -m uvicorn backend.app:app --host 0.0.0.0 --port "$PORT"
