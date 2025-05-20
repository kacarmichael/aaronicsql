#!/usr/bin/env bash

# Expected output
expected_output=$(
cat <<EOF
aaronicsql > Executed.
aaronicsql > (1, user1, person1@example.com)
Executed.
aaronicsql > 
EOF
)

# Run the script and capture output
actual_output=$(stdbuf -o0 ./repl.exe <<EOF
insert 1 user1 person1@example.com
select
.exit
EOF
)

# Compare actual output to expected
if [[ "$actual_output" == "$expected_output" ]]; then
  echo "✅ Test passed: insert and retrieve a row"
  exit 0
else
  echo "❌ Test failed: output mismatch"
  echo "Expected:"
  echo "$expected_output"
  echo
  echo "Got:"
  echo "$actual_output"
  exit 1
fi
