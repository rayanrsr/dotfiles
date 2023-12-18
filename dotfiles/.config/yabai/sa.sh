#!/bin/bash

# calculate new hash for the binary
SHA256=$(shasum -a 256 /opt/homebrew/bin/yabai | cut -d' ' -f 1)
echo "New yabai hash: $SHA256"

# replace the hash in-place in the sudoers file
sudo sed -i '' -e 's/sha256:[[:alnum:]]*/sha256:'${SHA256}'/' /private/etc/sudoers.d/yabai
