( echo 'ibase=2' ;
  sed 's/[FL]/0/g;s/[BR]/1/g' "$1" ) |
bc |
sort -n |
tail -1
