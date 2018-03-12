awk -F: '!($1%($2*2-2)) {sum += $1*$2} END {print sum}' tmp/day13.txt 

# to find out the modulus rules:
#awk -F: '{len=$2*2-2; print len, (5*len-$1)%len}' tmp/day13.txt | sort -n

# brute-force with shell takes about 10 seconds on my laptop :)
awk -F: '{for(c=-$1;c<3999999;c+=$2*2-2)print(c);}' tmp/day13.txt \
| grep -v '^-' \
| sort -nu \
| awk '$1 != last+1 && $1 {print last+1;} {last = $1}' \
| head -1
