#!/bin/sh

generate () {
     docker run --rm -v $(pwd):/bulletin --workdir /bulletin/_templates/ icecrime/vossibility-bulletin --source $1 generate weekly.md
}

for dir in *; do
    if [ -d $dir ]; then
        (cd $dir && generate $1)
    fi
done
