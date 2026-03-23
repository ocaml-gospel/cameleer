#!/bin/sh

dune clean
dune build

for file in "test"/*"ml"; do
    [ -e "${file}" ] || continue

    name="${file%.*}.coma"

    dune exec bin/cli_coma.exe -- --coma --pat "${file}" &> /dev/null

    if [ $? -eq 0 ]; then
        if [ -e "${name}" ]; then
            printf '\033[32m%s\033[0m\n' "ok: ${name}"
        else
            echo "error with the script"
            exit 1
        fi
    else
        printf '\033[31m%s\033[0m\n' "ko: ${file}"
    fi
done
