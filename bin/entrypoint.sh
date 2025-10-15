#!/bin/sh
set -e

# If model file doesn't exist, download it into /app/assets
MODEL_PATH=/app/assets/model_state_dict.bin
if [ ! -f "$MODEL_PATH" ]; then
  echo "Model not found at $MODEL_PATH — downloading..."
  cd /app || exit 1
  python bin/download_model
else
  echo "Model found at $MODEL_PATH"
fi

# exec the given command (uvicorn by default)
exec "$@"
