#!/bin/bash

ml_files=(applicative_queue arith binary_multiplication binary_search bst \
                            checking_a_large_routine cursor duplicates \
                            ephemeral_queue even_odd fact power fibonacci find \
                            fold \
                            insertion_sort_list isqrt leftist_heap logic \
                            mjrty pairing_heap program_proofs same_fringe \
                            stack tree_height_cps uf)

for f in "${ml_files[@]}"
do
    echo "Session of $f"
    why3 session info --stats -L ../stdlib $f
done
