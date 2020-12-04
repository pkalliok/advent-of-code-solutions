
from math import log, exp

def route(map, angle, gap):
    return (line[(i // gap * angle) % len(line)]
            for i, line in enumerate(map)
            if i % gap == 0)

def count_obstacles(map, angle, gap):
    return sum(1 for obj in route(map, angle, gap) if obj == "#")

directions = [(n, 1) for n in range(1,8,2)] + [(1,2)]

if __name__ == '__main__':
    import sys
    mymap = [line.rstrip() for line in open(sys.argv[1])]
    print(count_obstacles(mymap, 3, 1))
    print(round(exp(sum(log(count_obstacles(mymap, ang, gap))
        for ang, gap in directions))))

