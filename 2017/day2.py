
d = [[int(n) for n in l.split()] for l in open("tmp/day2.txt")]
print(sum(a-b for a,b in zip(map(max,d), map(min,d))))

print(sum(a//b for l in d for a in l for b in l if a!=b if not a%b))

