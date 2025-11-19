#!/bin/sh
#
# generate_funcname.sh
#
# This script processes C source files to extract function definitions
# and create a mapping from function names to some other identifier.
#
# Usage: ./generate_funcname.sh [C source files...]
#

# Input files passed as arguments to the script
# In the Makefile, this is usually '$^'
INPUT_FILES="$@"

# Environment variables for tools, with defaults if not set
CPP="${CPP:-cpp}"
AWK="${AWK:-awk}"
# CPPFLAGS can be passed from the environment

# If the C preprocessor is cl.exe (Microsoft Visual C++), use the /EP flag
# to direct preprocessor output to stdout.
#case "$CPP" in
#  *cl.exe*|*CL.EXE*)
#    CPPFLAGS="/EP"
#    ;;
#esac

# Check if input files are provided
if [ -z "$INPUT_FILES" ]; then
    echo "Usage: $0 <file1.c> [file2.c] ..." >&2
    exit 1
fi

# Step 1: Prepare the C preprocessor input.
# This consists of a custom DEFUN macro definition and the relevant lines
# extracted from the input source files using sed.
TMP_FL=$(mktemp --suffix=".c")

DEFUN_MACRO='#define DEFUN(x,y,z) x y'
EXTRACTED_LINES=$(sed -ne '/^DEFUN/{p;n;/^[ 	]/p;}' $INPUT_FILES)
PREPROCESSOR_INPUT="${DEFUN_MACRO}
${EXTRACTED_LINES}"


echo "$PREPROCESSOR_INPUT" > "$TMP_FL"



# Step 2: Run the C preprocessor on the generated input.
# The preprocessor expands the DEFUN macros.
PREPROCESSED_OUTPUT=$($CPP $CPPFLAGS "$TMP_FL" 2>/dev/null)

# Step 3: Process the preprocessed output with awk.
# This script extracts and reformats the data.
# For lines where the first field is a C-like identifier, it prints
# each subsequent field on a new line, followed by the first field.
# The final output is printed to standard output.
echo "$PREPROCESSED_OUTPUT" | $AWK '$1 ~ /^[_A-Za-z]/ {
    for (i=2; i<=NF; i++) {
        print $i, $1
    }
}'
unlink "$TMP_FL"