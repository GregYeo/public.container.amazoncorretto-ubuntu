#!/bin/bash -e;

echo "Who am i? $(whoami)."

echo "================================="
echo "=== Trying 'apt update'"
echo "================================="
apt update
status=$?
echo "================================="
echo "=== End of 'apt update'"
echo "================================="
if [ "0" -eq "$status" ]; then
  echo "I could use 'apt update'."
else
  echo "I failed to run 'apt update'. root user should be able to run system command"
  exit 1
fi

echo "I could use 'apt update' command"