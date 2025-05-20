#!/usr/bin/env bash

#!/usr/bin/env bash

# Build the input commands: insert 1 ... insert 1401
commands=""
for i in $(seq 1 1401); do
  commands+="insert ${i} user${i} person${i}@example.com"$'\n'
done
commands+='.exit'

#!/usr/bin/env bash

# Build the input commands: insert 1 ... insert 1401
commands=""
for i in $(seq 1 1401); do
  commands+="insert ${i} user${i} person${i}@example.com"$'\n'
done
commands+='.exit'

# Run the database binary with unbuffered output
actual_output=$(echo "$commands" | stdbuf -o0 ./repl.exe)

# Get the second-to-last line (where the error is expected)
second_last_line=$(echo "$actual_output" | tail -n 2 | head -n 1)

expected_line="aaronicsql > Error: Table is full."

# Perform the comparison
if [[ "$second_last_line" == "$expected_line" ]]; then
  echo "✅ Test passed: prints error message when table is full"
  exit 0
else
  echo "❌ Test failed: did not detect 'table full' error correctly"
  echo "Expected:"
  echo "$expected_line"
  echo
  echo "Got:"
  echo "$second_last_line"
  exit 1
fi
