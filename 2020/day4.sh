valid() {
  sed 's/^$/___/' |
  egrep -o "$1" |
  awk '/___/ { pp++; } { printf("%04d %s\n", pp, $0); }' |
  sort |
  cut -c6- |
  grep -v '^cid:' |
  tr \\012 ' ' |
  sed 's/ ___ /\n/g' |
  awk 'NF == 7' |
  wc -l
}

CRIT1='___|[a-z]{3}:[^ ]*'
CRIT2='___|
	|byr:(19[2-9][0-9]|200[012])\>|
	|iyr:(201[0-9]|2020)\>|
	|eyr:(202[0-9]|2030)\>|
	|hgt:((1[5-8][0-9]|19[0-3])cm|(59|6[0-9]|7[0-6])in)\>|
	|hcl:#[0-9a-f]{6}\>|
	|ecl:(amb|blu|brn|gry|grn|hzl|oth)\>|
	|pid:[0-9]{9}\>'

valid "$CRIT1" < "$1"
valid "$CRIT2" < "$1"

