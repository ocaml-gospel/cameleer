#!/bin/bash

ml_files=(applicative_queue arith binary_multiplication binary_search \
                            binary_search_tree checking_a_large_routine \
                            cnf_conversion duplicates \
                            ephemeral_queue even_odd fact fast_exponentiation \
                            fibonacci find insertion_sort_list isqrt \
                            leftist_heap mjrty ocaml_fold ocaml_stack \
                            pairing_heap program_proofs same_fringe \
                            small_step_iterator tree_height_cps union_find)

for f in "${ml_files[@]}"
do
    echo "Replaying session of $f"
    hyperfine -w 3 -m $1 "why3 replay --quiet $f"
done
