#!/bin/bash -e;

echo "Who am i? $(whoami)."

set +e;
echo "================================="
echo "=== Trying 'touch /bin/123'"
echo "================================="
touch /bin/123
status=$?
echo "================================="
echo "=== End of 'touch /bin/123'"
echo "================================="
echo "Status: $status"

if [ "0" -ne "$status" ]; then
  echo "I failed to touch where root permission only space"
else
  echo "I could touch '/bin/123'. Non root user shouldn't be able to touch under '/bin'"
  exit 1
fi

echo "================================="
echo "=== Trying 'apt update'"
echo "================================="
apt update
status=$?
echo "================================="
echo "=== End of 'apt update'"
echo "================================="
echo "Status: $status"

if [ "0" -ne "$status" ]; then
  echo "I failed to run 'apt update'"
else
  echo "I could use 'apt update'. Non root user shouldn't be able to run system command like 'apt'"
  exit 1
fi

echo "Show me current java version"
java --version
