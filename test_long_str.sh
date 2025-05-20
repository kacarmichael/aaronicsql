#!/usr/bin/env bash

# Define max-length strings
long_username=$(printf 'a%.0s' {1..32})
long_email=$(printf 'a%.0s' {1..255})

# Build input commands
input_commands=$(
cat <<EOF
insert 1 $long_username $long_email
select
.exit
EOF
)

# Expected output
expected_output=$(
cat <<EOF
aaronicsql > Executed.
aaronicsql > (1, $long_username, $long_email)
Executed.
aaronicsql > 
EOF
)

# Run the database and capture output
actual_output=$(echo "$input_commands" | stdbuf -o0 ./repl.exe)

# Compare actual vs expected
if [[ "$actual_output" == "$expected_output" ]]; then
  echo "✅ Test passed: allows inserting strings that are the maximum length"
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
