#!/bin/zsh

# Assert function to compare expected and actual output
assert() {
    local test_name="$1"
    local expected="$2"
    local actual="$3"

    # Use printf to ensure formatting is preserved
    expected=$(printf "%b" "$expected")
    actual=$(printf "%b" "$actual")

    # Compare actual output to expected output
    if [[ "$actual" == "$expected" ]]; then
        echo "✅ Test '$test_name' Passed"
    else
        echo "❌ Test '$test_name' Failed: Expected >>>"
        echo "$expected"
        echo "<<<"
        echo "But got >>>"
        echo "$actual"
        echo "<<<"
        exit 1
    fi
}


# Test Simple Example
read -r -d '' expected_output <<'EOF'
Welcome, Alice!

EOF
actual_output=$(./examples/simple_example.sh --username Alice)
assert "./examples/simple_example.sh --username Alice" "$expected_output" "$actual_output"

# Test Flags Example
read -r -d '' expected_output <<'EOF'
Debug mode is ON.
EOF
actual_output=$(./examples/flags_example.sh --debug)
assert "./examples/flags_example.sh --debug" "$expected_output" "$actual_output"

read -r -d '' expected_output <<'EOF'
Debug mode is OFF.
EOF
actual_output=$(./examples/flags_example.sh)
assert "./examples/flags_example.sh" "$expected_output" "$actual_output"

# Test Optional Required Example
read -r -d '' expected_output <<'EOF'
Output will be saved to: ./output.txt
Verbose mode enabled.
Operating in mode: test
EOF
actual_output=$(./examples/optional_required_example.sh --mode "test" --verbose)
assert "./examples/optional_required_example.sh --mode 'test' --verbose" "$expected_output" "$actual_output"

read -r -d '' expected_output <<'EOF'
Output will be saved to: /path/to/file
Operating in mode: prod
EOF
actual_output=$(./examples/optional_required_example.sh --mode "prod" --output "/path/to/file")
assert "./examples/optional_required_example.sh --mode 'prod' --output '/path/to/file'" "$expected_output" "$actual_output"

# Test -h
read -r -d '' expected_output <<'EOF'
This script demonstrates optional and required arguments.

options:
  --output [TXT]: Path to output file
  --verbose: Enable verbose mode
  --mode [TXT]: Operation mode
EOF
actual_output=$(./examples/optional_required_example.sh -h)
assert "./examples/optional_required_example.sh -h" "$expected_output" "$actual_output"
