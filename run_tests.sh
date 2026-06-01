#!/bin/sh

RESET="\033[0m"
RED="\033[31m"
GREEN="\033[32m"

WHY3="${WHY3:-${HOME}/.opam/cameleer-tutorial/bin/why3}"

if [ ! -e ${WHY3} ]; then
    printf "${RED}%s${RESET}\n" "${WHY3} is not a valid why3"
    exit 1
fi

files="${1:-test/*.ml}"

for file in ${files}; do
    [ -e "${file}" ] || continue

    name="${file%.*}.coma"

    dune exec bin/cli_coma.exe -- --coma --pat "${file}" >/dev/null 2>&1

    if [ $? -eq 0 ]; then
        if [ -e "${name}" ]; then
            printf "${GREEN}%s${RESET}\n" "ok: ${name}"
            if "${WHY3}" prove "./${name}" > /dev/null 2>&1; then
                printf "${GREEN}%s${RESET}\n" "    why3 prove succeed"
            else
                printf "${RED}%s${RESET}\n" "    why3 prove failed"
            fi
        else
            echo "error with the script"
            exit 1
        fi
    else
        printf "${RED}%s${RESET}\n" "ko: ${file}"
    fi
done
