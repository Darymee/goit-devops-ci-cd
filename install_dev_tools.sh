#!/bin/bash

set -e

echo "=== Checking and installing development tools ==="

# Homebrew

if command -v brew &> /dev/null; then
echo "Homebrew is already installed."
else
echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Docker

if command -v docker &> /dev/null; then
echo "Docker is already installed."
else
echo "Installing Docker..."
brew install --cask docker
fi

# Docker Compose

if docker compose version &> /dev/null; then
echo "Docker Compose is already installed."
else
echo "Installing Docker Compose..."
brew install docker-compose
fi

# Python

if command -v python3 &> /dev/null; then
PYTHON_VERSION=$(python3 --version)
echo "$PYTHON_VERSION is already installed."
else
echo "Installing Python..."
brew install python
fi

# Django

if python3 -m django --version &> /dev/null; then
echo "Django $(python3 -m django --version) is already installed."
else
echo "Installing Django..."
pip3 install django
fi

echo ""
echo "=== Installed Versions ==="
docker --version || true
docker compose version || true
python3 --version || true
python3 -m django --version || true

echo "=== Installation completed successfully ==="
