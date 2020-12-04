sed 's/^$/___/' |
egrep -o '___|[a-z]{3}:[^ ]*' |
awk '/___/ { pp++; } { printf("%04d %s\n", pp, $0); }' |
sort |
cut -c6- |
grep -v '^cid:' |
tr \\012 ' ' |
sed 's/ ___ /\n/g' |
awk 'NF == 7' |
wc -l
