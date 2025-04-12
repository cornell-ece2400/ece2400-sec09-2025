#!/bin/bash
set -eo pipefail

./scripts/build.sh -DCMAKE_BUILD_TYPE=Release

# Remove the previous results file

rm -f slist-dpoly-reverse-v2-eval.txt

# Run the evaluation

for i in {2000,4000,6000,8000,10000}; do
  ./build/eval/slist-dpoly-reverse-v2-eval $i | tee -a slist-dpoly-reverse-v2-eval.txt;
done

