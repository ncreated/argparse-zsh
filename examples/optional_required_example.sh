#!/bin/zsh

# Source the argparse script
source ./argparse.sh

# Set script description
set_description "This script demonstrates optional and required arguments."

# Define arguments
define_arg "output" "./output.txt" "Path to output file" "string"
define_arg "verbose" "false" "Enable verbose mode" "store_true"
define_arg "mode" "" "Operation mode" "string" "true"
define_arg "dashed-flag" "false" "Flag with '-'" "store_true"
define_arg "dashed-arg" "default arg value" "Argument with '-'" "string" "store_true" "false"

# Check for -h and --help
check_for_help "$@"

# Parse the arguments
parse_args "$@"

# Main script logic
echo "Output will be saved to: $output"
[[ $verbose == "true" ]] && echo "Verbose mode enabled."
echo "Operating in mode: $mode"
echo "--dashed-flag: $dashed_flag"
echo "--dashed-arg: $dashed_arg"

# Usage:
# ./optional_required_example.sh --mode "test" --verbose
# ./optional_required_example.sh --mode "prod" --output "/path/to/file"
# ./optional_required_example.sh --mode "prod" --output "/path/to/file" --dashed-arg "dashed arg value"
# ./optional_required_example.sh --mode "prod" --output "/path/to/file" --dashed-flag