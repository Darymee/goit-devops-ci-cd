#!/usr/bin/env bash

set -euo pipefail

MIN_PYTHON_VERSION="3.9"

echo "=== Checking and installing development tools for Ubuntu / Debian ==="

if ! command -v apt-get >/dev/null 2>&1; then
  echo "Error: this script supports Ubuntu / Debian systems with apt-get." >&2
  exit 1
fi

if [ "${EUID:-$(id -u)}" -ne 0 ]; then
  SUDO="sudo"
else
  SUDO=""
fi

version_ge() {
  python3 - "$1" "$2" <<'PY'
from packaging.version import Version
import sys
sys.exit(0 if Version(sys.argv[1]) >= Version(sys.argv[2]) else 1)
PY
}

$SUDO apt-get update
$SUDO apt-get install -y ca-certificates curl gnupg lsb-release software-properties-common python3-pip python3-venv

# Docker Engine + Docker Compose plugin
if command -v docker >/dev/null 2>&1; then
  echo "Docker is already installed: $(docker --version)"
else
  echo "Installing Docker Engine..."
  $SUDO install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/$(. /etc/os-release && echo "$ID")/gpg | $SUDO gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  $SUDO chmod a+r /etc/apt/keyrings/docker.gpg
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/$(. /etc/os-release && echo "$ID") \
    $(lsb_release -cs) stable" | $SUDO tee /etc/apt/sources.list.d/docker.list >/dev/null
  $SUDO apt-get update
  $SUDO apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
fi

if docker compose version >/dev/null 2>&1; then
  echo "Docker Compose is installed: $(docker compose version)"
else
  echo "Error: Docker Compose plugin was not installed correctly." >&2
  exit 1
fi

# Python 3.9+
if command -v python3 >/dev/null 2>&1; then
  CURRENT_PYTHON_VERSION=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:3])))')
  if version_ge "$CURRENT_PYTHON_VERSION" "$MIN_PYTHON_VERSION"; then
    echo "Python $CURRENT_PYTHON_VERSION is already installed and meets requirement >= $MIN_PYTHON_VERSION."
  else
    echo "Python $CURRENT_PYTHON_VERSION is below required $MIN_PYTHON_VERSION. Installing newer Python..."
    $SUDO add-apt-repository -y ppa:deadsnakes/ppa
    $SUDO apt-get update
    $SUDO apt-get install -y python3.11 python3.11-venv python3.11-dev
    CURRENT_PYTHON_VERSION=$(python3.11 -c 'import sys; print(".".join(map(str, sys.version_info[:3])))')
    echo "Installed Python $CURRENT_PYTHON_VERSION. Use python3.11 for this project."
  fi
else
  echo "Installing Python 3.11..."
  $SUDO add-apt-repository -y ppa:deadsnakes/ppa
  $SUDO apt-get update
  $SUDO apt-get install -y python3.11 python3.11-venv python3.11-dev python3-pip
fi

PYTHON_BIN="python3"
if ! $PYTHON_BIN - <<PY >/dev/null 2>&1
import sys
raise SystemExit(0 if sys.version_info >= (3, 9) else 1)
PY
then
  PYTHON_BIN="python3.11"
fi

# Django
if $PYTHON_BIN -m django --version >/dev/null 2>&1; then
  echo "Django $($PYTHON_BIN -m django --version) is already installed."
else
  echo "Installing Django..."
  $PYTHON_BIN -m pip install --user django
fi

echo ""
echo "=== Installed Versions ==="
docker --version || true
docker compose version || true
$PYTHON_BIN --version || true
echo "Django version $($PYTHON_BIN -m django --version)"

echo "=== Installation completed successfully ==="
