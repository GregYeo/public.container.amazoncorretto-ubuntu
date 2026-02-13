#!/bin/sh
# Use POSIX compliant parameter expansion for defaults
export USER_ID="${TARGET_UID:-1000}"
export GROUP_ID="${TARGET_GID:-1000}"

if ! getent passwd "$USER_ID" > /dev/null; then
  # Create a temporary user for this UID
  useradd -u "$USER_ID" -m temporary_user
fi

if [ -n "$ROOT_USER_SCRIPT" ] && [ -f "$ROOT_USER_SCRIPT" ]; then
  echo "Running root-level initialization script: $ROOT_USER_SCRIPT"
  . "$ROOT_USER_SCRIPT"
fi

# Verify if setpriv exists before executing
if ! command -v setpriv >/dev/null 2>&1; then
  echo "Error: setpriv not found in this image!"
  exit 1
fi

echo "User is switching into > UID:GID($USER_ID:$GROUP_ID)"
exec setpriv --reuid="$USER_ID" --regid="$GROUP_ID" --init-groups "$@"