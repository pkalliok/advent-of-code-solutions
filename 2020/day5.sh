( echo 'ibase=2' ;
  sed 's/[FL]/0/g;s/[BR]/1/g' "$1" ) |
bc |
sort -n |
awk '$1 - prev > 1 { print $1 - 1 }
  { prev = $1 }
  END { print prev }'
