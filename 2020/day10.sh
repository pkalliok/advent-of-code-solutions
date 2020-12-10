( echo 0; cat "$1" ) |
sort -n |
awk '{ jolt[$1-prev]++; prev = $1 } END { print jolt[1] * (jolt[3]+1) }'
