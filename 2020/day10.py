
from itertools import groupby
from functools import reduce

def adapters_from_file(f):
    return sorted([0] + [int(line) for line in f])

def indet_groups(adapters):
    g = groupby(zip(adapters, adapters[1:]), lambda pair: pair[1]-pair[0] == 3)
    return (set(ad for ads in grp for ad in ads) for v, grp in g if not v)

# This would be much harder if there actually was 2 jolt increases, or
# longer periods of 1-jolt increases than 4.  But there don't seem to
# be.

def number_paths(indet_group):
    return {1: 1, 2: 1, 3: 2, 4: 4, 5: 7}[len(indet_group)]

def total_number_paths(indet_groups):
    return reduce(lambda a,b:a*b, map(number_paths, indet_groups))

if __name__ == '__main__':
    import sys
    print(total_number_paths(indet_groups(adapters_from_file(open(sys.argv[1])))))

