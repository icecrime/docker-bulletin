#!/bin/sh

generate () {
     docker run --rm -v $(pwd):/bulletin --workdir /bulletin/_templates/ icecrime/vossibility-bulletin --source $1 generate weekly.md
}

for dir in *; do
    if [ -d $dir ]; then
        (cd $dir && generate $1) > $dir/$(date "+%Y-%m-%d").md
    fi
done

git add * && git commit -sm "Generate reports" && git push origin
