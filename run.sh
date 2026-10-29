#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export PATH="$DIR/.local_tools/bin:$PATH"
export PYTHONPATH="$DIR:$DIR/backend:$PYTHONPATH"

echo "===================================================="
echo " FloodWatch AI — Starting Backend and Frontend"
echo "===================================================="

# Start backend
echo "Starting FastAPI Backend on http://localhost:8000..."
"$DIR/.venv/bin/uvicorn" backend.app.main:app --host 0.0.0.0 --port 8000 &
BACKEND_PID=$!

# Start frontend
echo "Starting Angular Frontend on http://localhost:4200..."
cd "$DIR/Frontend" && npm start &
FRONTEND_PID=$!

trap "kill $BACKEND_PID $FRONTEND_PID 2>/dev/null; exit 0" SIGINT SIGTERM EXIT
wait

