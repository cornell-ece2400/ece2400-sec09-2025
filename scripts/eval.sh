#!/bin/bash
set -eo pipefail

ROOT=$(basename $(pwd))

if ./scripts/build.sh -DCMAKE_BUILD_TYPE=Release ; then
    echo "Build successful"
else
    echo "Fix build errors above"
    exit 1
fi

# Running /tests
echo "Running tests..."
if make test; then
    echo "Tests passed"
    echo "Recording execution time..."

    echo "Evaluating reverse-v1..." >> results.txt
    ./build/eval/slist-int-reverse-v1-eval $@ 2>&1 | tee -a results.txt
    echo "===========================" >> results.txt
    echo "Evaluating reverse-v2..." >> results.txt
    ./build/eval/slist-int-reverse-v2-eval $@ 2>&1 | tee -a results.txt

else
    echo "Tests failed"
    echo "SKIPPED: evaluation"

fi
