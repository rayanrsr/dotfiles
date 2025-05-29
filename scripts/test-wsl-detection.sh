#!/bin/bash

# Test script to verify WSL detection
echo "🔍 Testing WSL detection..."

# Function to detect if running in WSL
is_wsl() {
  if [ -f /proc/version ] && grep -qi microsoft /proc/version; then
    return 0  # true - running in WSL
  elif [ -f /proc/sys/kernel/osrelease ] && grep -qi microsoft /proc/sys/kernel/osrelease; then
    return 0  # true - running in WSL
  elif [ -n "${WSL_DISTRO_NAME}" ] || [ -n "${WSLENV}" ]; then
    return 0  # true - running in WSL
  else
    return 1  # false - not running in WSL
  fi
}

# Test the detection
if is_wsl; then
  echo "✅ WSL detected!"
  echo "   - GUI applications and games will be skipped"
  echo "   - Only common packages will be installed"
else
  echo "✅ Native Linux detected!"
  echo "   - All packages including GUI applications will be installed"
  echo "   - ulauncher, steam, heroic-game-launcher-bin will be installed"
fi

# Show detection details
echo ""
echo "🔍 Detection details:"
echo "   - /proc/version exists: $([ -f /proc/version ] && echo "yes" || echo "no")"
if [ -f /proc/version ]; then
  echo "   - /proc/version contains 'microsoft': $(grep -qi microsoft /proc/version && echo "yes" || echo "no")"
fi
echo "   - WSL_DISTRO_NAME: ${WSL_DISTRO_NAME:-"not set"}"
echo "   - WSLENV: ${WSLENV:-"not set"}" 