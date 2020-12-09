sed 's/^$/_/' |
egrep -o . |
awk '/^_$/ { pp++; } { printf("%04d %s\n", pp, $0); }' |
sort -u |
cut -c6- |
grep -v _ |
wc -l
