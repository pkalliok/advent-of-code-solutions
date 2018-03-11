awk -F: '$1 % ($2 * 2 - 2) == 0 {sum += $1*$2} END {print sum}' tmp/day13.txt 
