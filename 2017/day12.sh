newprogs=0
until test "X$newprogs" = "X$progs"; do
 progs="$newprogs"
 newprogs=$(egrep "^($progs) " tmp/day12.txt \
 | cut -d'>' -f2 \
 | tr -s ' ,' '\012' \
 | sort -u \
 | tr \\012 '|' \
 | sed 's/^|//;s/|$//')
 #echo "$newprogs"
done

echo "$progs" | tr -dc '|' | sed 's/$/|/' | wc -c

